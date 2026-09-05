#!/usr/bin/env python3
"""Render the stakeholders of the SysML v2 model as a Markdown table.

The SysML model is the single source of truth. This script only reads it and
writes a generated view; it never modifies the model.

This is deliberately not a SysML v2 parser. It recognises exactly the modeling
conventions used in this repository, as described in
method/02-stakeholders-and-needs.md:

    #extendedStakeholder part def <StakeholderName> {
        doc
        /* <who the stakeholder is> */

        attribute :>> risk = LevelKind::<level>;
        attribute :>> effort = LevelKind::<level>;
        attribute :>> categories = StakeholderCategoryKind::<category>;
    }

The needs of a stakeholder are the concern definitions that declare it as their
stakeholder. Anything that does not follow these conventions is reported as an
error rather than silently skipped.
"""

import argparse
from pathlib import Path

import sysml_read
from sysml_read import REPO, cell, documentation, fail, humanize

MODEL = REPO / "model" / "DeskCoolingStakeholders.sysml"
OUTPUT = REPO / "build" / "stakeholders.md"

# SYSMOD derives the stakeholder priority as risk * effort, with these values
# for LevelKind. Source: SYSMOD.sysml, LevelKind and ExtendedStakeholder.
LEVELS = {"none": 0.0, "low": 0.25, "medium": 0.5, "high": 0.75, "critical": 1.0}

# Explains the priority column. The approach is SYSMOD's own, so it is named
# rather than left for the reader to guess at.
DESCRIPTION = [
    "Priority follows the SYSMOD stakeholder priority map.",
    "Score: `priority = risk * effort`, with `LevelKind` values from `none` 0 to",
    "`critical` 1.0. Effort multiplies rather than divides, so a stakeholder who is",
    "both consequential and hard to reach ranks highest (`SYSMOD.sysml`,",
    "`ExtendedStakeholder`).",
    "",
]


def label(literal):
    """requirementOwner -> Requirement Owner."""
    return humanize(literal[0].upper() + literal[1:])


def level(model, name, line, attribute, body):
    """Read a LevelKind attribute and return (literal, numeric value)."""
    values = sysml_read.enum_values(body, attribute)
    if not values:
        fail(model, line, f"stakeholder definition '{name}' redefines no {attribute}")
    if values[0] not in LEVELS:
        fail(model, line, f"stakeholder definition '{name}' has unknown {attribute} "
                          f"level '{values[0]}'")
    return values[0], LEVELS[values[0]]


def read_needs_by_stakeholder(model, text):
    """Map each stakeholder definition name to its needs, in model order."""
    needs = {}
    for name, body, line in sysml_read.definition_blocks(text, sysml_read.CONCERN_DEF):
        if body is None:
            fail(model, line, f"concern definition '{name}' is not closed")
        for reference in sysml_read.STAKEHOLDER_PARAM.findall(body):
            needs.setdefault(reference.split("::")[-1], []).append(name)
    return needs


def read_stakeholders(model):
    """Return the stakeholders of the model, in model order."""
    text = sysml_read.read_model(model)
    needs = read_needs_by_stakeholder(model, text)

    stakeholders = []
    for name, body, line in sysml_read.definition_blocks(text, sysml_read.STAKEHOLDER_DEF):
        if body is None:
            fail(model, line, f"stakeholder definition '{name}' is not closed")

        categories = sysml_read.enum_values(body, "categories")
        if not categories:
            fail(model, line, f"stakeholder definition '{name}' redefines no categories")

        risk, risk_value = level(model, name, line, "risk", body)
        effort, effort_value = level(model, name, line, "effort", body)

        stakeholders.append(
            {
                "name": name,
                "description": documentation(
                    model, f"stakeholder definition '{name}'", body, line
                ),
                "categories": categories,
                "risk": risk,
                "effort": effort,
                "priority": risk_value * effort_value,
                "needs": needs.pop(name, []),
            }
        )

    if not stakeholders:
        fail(model, 1, "no stakeholder definitions found")

    for unknown, referring in sorted(needs.items()):
        fail(model, 1, f"need '{referring[0]}' declares the stakeholder '{unknown}', "
                       f"which is not defined in this model")
    return stakeholders


def render(stakeholders, model, output):
    lines = sysml_read.header_lines(
        "Stakeholders", model, output, "the stakeholders and their needs"
    )
    lines += DESCRIPTION
    lines += [
        "| Stakeholder | Description | Categories | Risk | Effort | Priority | Needs |",
        "| ----------- | ----------- | ---------- | ---- | ------ | -------- | ----- |",
    ]
    for stakeholder in stakeholders:
        lines.append(
            "| {} | {} | {} | {} | {} | {} | {} |".format(
                humanize(stakeholder["name"]),
                cell(stakeholder["description"]),
                ", ".join(label(c) for c in stakeholder["categories"]),
                stakeholder["risk"].capitalize(),
                stakeholder["effort"].capitalize(),
                f"{stakeholder['priority']:.4f}".rstrip("0").rstrip("."),
                ", ".join(humanize(n) for n in stakeholder["needs"]) or "--",
            )
        )
    lines.append("")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--model", type=Path, default=MODEL, help="SysML model file to read")
    parser.add_argument("--output", type=Path, default=OUTPUT, help="Markdown file to write")
    args = parser.parse_args()

    stakeholders = read_stakeholders(args.model)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(render(stakeholders, args.model, args.output), encoding="utf-8")
    print(f"render-stakeholders: wrote {args.output} ({len(stakeholders)} stakeholders)")


if __name__ == "__main__":
    main()
