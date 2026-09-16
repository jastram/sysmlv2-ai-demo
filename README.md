# SysML v2 AI Demo

AI-assisted systems engineering demo using SysML v2, Syside, and a tailored SYSMOD-based method. The repository develops a small greenfield product step by step from stakeholder needs to requirements, architecture, and verification.

## Product: Intelligent Desk Cooling Device

This repository contains a small demonstration project for AI-assisted
systems engineering with SysML v2 and Syside.

## Project Frame

The product provides relief to a person who is too warm at their desk,
without changing the conditions of the room around them.

The project is a greenfield development and serves as an educational
demonstrator. The model is intentionally small and follows the KISS
principle.

The development starts from the problem and the stakeholder needs. It does
not assume a technical solution: the kind of solution is committed to in
activity 2 of [`method/00-development-process.md`](method/00-development-process.md),
as an explicit and recorded decision, because the system boundary cannot be
drawn without one. That commitment is a USB-powered tabletop fan. Everything
inside it — how the airflow is produced, directed, and controlled — remains a
later design choice.

Regulatory engineering and product certification are outside the scope
of this demonstration.

## Getting Started

### Clone

This repository uses a Git submodule for the SYSMOD library, so clone it
recursively:

```bash
git clone --recurse-submodules git@github.com:jastram/sysmlv2-ai-demo.git
```

If the repository was already cloned without that flag, the
`references/sysmod-sysmlv2/` directory will be empty. Populate it with:

```bash
git submodule update --init --recursive
```

### Reference Material

External reference material lives in [`references/`](references/) and is, with one
exception, not tracked in this repository. See
[`references/README.md`](references/README.md) for the full reference manifest.

The exception is the SYSMOD library, which the model actually depends on:

| Reference | Access |
| --- | --- |
| SYSMOD for SysML v2 | Git submodule at `references/sysmod-sysmlv2/`, pinned to an upstream revision |
| The SysML v2 Book | Licensed; keep outside the repository |
| OMG SysML v2 Specification | Obtain separately; keep outside the repository |

The submodule is pinned to a specific upstream commit so that the model always
resolves against a known version of the library. To move it to the latest upstream
`main` and record the new revision:

```bash
git submodule update --remote references/sysmod-sysmlv2
git add references/sysmod-sysmlv2
git commit -m "Update SYSMOD library"
```

Check the currently pinned revision at any time with:

```bash
git submodule status
```

The SYSMOD library is Copyright MBSE4U, Tim Weilkiens, and licensed under the
Apache License 2.0. It is referenced, not redistributed: this repository stores
only the upstream URL and commit, and the submodule must not be modified locally.

### Validation

[`syside.toml`](syside.toml) loads `references/sysmod-sysmlv2/SYSMOD.sysml` as an
external library, so the submodule must be initialized before the model in
[`model/`](model/) will resolve.

## Generated Views

The SysML v2 model in [`model/`](model/) is the single source of truth. Readable
views are generated from it and are never edited by hand.

```bash
python tools/render-needs.py
python tools/render-stakeholders.py
```

The first writes the stakeholder needs table to `build/stakeholder-needs.md`,
the second the stakeholder table to `build/stakeholders.md`. The `build/`
directory is generated and not tracked in Git.

## License

This repository is licensed under the MIT License.

External reference material is not part of this repository and remains subject
to its respective copyright and licensing terms. See
[`references/README.md`](references/README.md).
