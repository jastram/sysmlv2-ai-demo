# SysML v2 AI Demo

AI-assisted systems engineering demo using SysML v2, Syside, and a tailored SYSMOD-based method. The repository develops a small greenfield product step by step from stakeholder needs to requirements, architecture, and verification.

## Product: Intelligent Desk Cooling Device

This repository contains a small demonstration project for AI-assisted
systems engineering with SysML v2 and Syside.

## Project Frame

The product is a small intelligent desktop cooling device. Its purpose is
to provide cooling to a person working at a desk and to adapt the airflow
to the person's position.

The project is a greenfield development and serves as an educational
demonstrator. The model is intentionally small and follows the KISS
principle.

The development starts from stakeholder needs and must not assume a
specific technical solution. A fan, camera, sensors, motors, or other
implementation technologies are possible later design choices, not part
of the initial problem definition.

Regulatory engineering and product certification are outside the scope
of this demonstration.

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
