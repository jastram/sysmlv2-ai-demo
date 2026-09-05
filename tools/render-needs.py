#!/usr/bin/env python3
"""Render the stakeholder needs of the SysML v2 model as a Markdown table.

The SysML model is the single source of truth. This script only reads it and
writes a generated view; it never modifies the model.

This is deliberately not a SysML v2 parser. It recognises exactly the modeling
conventions used in this repository, as described in
method/02-stakeholders-and-needs.md:

    #extendedConcern concern def <NeedName> {
        doc
        /* <the need sentence> */

        subject systemOfInterest;

        stakeholder <role> : <StakeholderDefinition>;

        attribute :>> priority = LevelKind::<level>;
    }

Anything that does not follow these conventions is reported as an error rather
than silently skipped.
"""

import argparse
from pathlib import Path

import sysml_read
from sysml_read import REPO, cell, documentation, fail, humanize

MODEL = REPO / "model" / "DeskCoolingStakeholders.sysml"
OUTPUT = REPO / "build" / "stakeholder-needs.md"




def read_needs(model):
    """Return the needs of the model, in model order."""
    text = sysml_read.read_model(model)

    needs = []
    for name, body, line in sysml_read.definition_blocks(text, sysml_read.CONCERN_DEF):
        if body is None:
            fail(model, line, f"concern definition '{name}' is not closed")

        priority = sysml_read.enum_values(body, "priority")
        if not priority:
            fail(model, line, f"concern definition '{name}' redefines no priority")

        stakeholders = [s.split("::")[-1] for s in sysml_read.STAKEHOLDER_PARAM.findall(body)]
        if not stakeholders:
            fail(model, line, f"concern definition '{name}' declares no stakeholder")

        needs.append(
            {
                "name": name,
                "description": documentation(model, f"concern definition '{name}'", body, line),
                "priority": priority[0],
                "stakeholders": stakeholders,
            }
        )

    if not needs:
        fail(model, 1, "no concern definitions found")
    return needs


def render(needs, model, output):
    lines = sysml_read.header_lines(
        "Stakeholder Needs", model, output, "the stakeholder needs"
    )
    lines += [
        "| Need | Description | Priority | Stakeholder |",
        "| ---- | ----------- | -------- | ----------- |",
    ]
    for need in needs:
        lines.append(
            "| {} | {} | {} | {} |".format(
                humanize(need["name"]),
                cell(need["description"]),
                need["priority"].capitalize(),
                ", ".join(humanize(s) for s in need["stakeholders"]),
            )
        )
    lines.append("")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--model", type=Path, default=MODEL, help="SysML model file to read")
    parser.add_argument("--output", type=Path, default=OUTPUT, help="Markdown file to write")
    args = parser.parse_args()

    needs = read_needs(args.model)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(render(needs, args.model, args.output), encoding="utf-8")
    print(f"render-needs: wrote {args.output} ({len(needs)} needs)")


if __name__ == "__main__":
    main()
