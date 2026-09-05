# Reference Library

This directory describes the external knowledge sources available for developing the product-specific method and system model.

The reference material itself does not need to be stored in this repository. References may point to external repositories, local files, or online resources.

## Purpose

The reference library provides source material for:

* development methodology;
* SysML v2 language semantics and notation;
* modeling examples and patterns;
* tool-specific behavior and capabilities.

Reference material is not automatically part of the product-specific method. Relevant guidance must be evaluated and tailored before becoming normative for this product.

The tailored method is maintained in [`../method/`](../method/).

## Authority

Different references answer different questions.

### Methodology

Methodological references define or explain engineering approaches, activities, and modeling practices.

Current sources:

* **SYSMOD for SysML v2**
  Primary methodological reference.
* **The SysML v2 Book, Tim Weilkiens**
  Methodological explanation, SysML v2 guidance, and examples.

### Language

Language references define SysML v2 syntax and semantics.

Current source:

* **OMG SysML v2 Specification**
  Authoritative source for SysML v2 language semantics.

### Tooling

Tool references describe implementation-specific behavior.

Current source:

* **Syside documentation**
  Authoritative source for Syside-specific capabilities, validation, and behavior.

Methodological suitability must not be inferred from language validity or tool support.

## Reference Access

Reference material is accessed in one of two ways, depending on whether it can be
redistributed and whether pinning an exact revision matters.

### Tracked References: Git Submodules

Public Git repositories that the model depends on are included as Git submodules.
The submodule records the exact upstream revision, so the model resolves against a
known version of its library rather than whatever happens to be on disk.

This directory currently contains one submodule:

| Path | Upstream |
| --- | --- |
| `sysmod-sysmlv2/` | <https://github.com/MBSE4U/sysmod-sysmlv2> |

The contents of a submodule are not stored in this repository; only its URL and the
pinned commit are. Everything else under `references/` is ignored by Git.

Setup and update commands are documented in the [root README](../README.md#reference-material).

### Untracked References: Reference Root

Large or licensed reference material must remain outside this repository and is not
tracked in any form.

Local references should be accessible through a configurable reference root rather
than machine-specific absolute paths. For example:

```text
$SYSML_KNOWLEDGE/
├── sysml-v2-book/
├── sysml-v2-specification/
└── syside/
```

AI agents working on this repository should be given read access to this location
when reference material is required.

## Reference Manifest

For each reference used by the project, record:

* title;
* author or organization;
* version, edition, or Git revision where applicable;
* category: methodology, language, or tooling;
* local location or public source;
* licensing restrictions where relevant.

### SYSMOD for SysML v2

- Category: Methodology
- Author: Tim Weilkiens / MBSE4U
- Version: pinned by the Git submodule; see `git submodule status`
- Location: `references/sysmod-sysmlv2/` (Git submodule)
- Public source: <https://github.com/MBSE4U/sysmod-sysmlv2>
- Copyright: MBSE4U, Tim Weilkiens
- License: Apache License 2.0 (referenced as a submodule, not redistributed)

### The SysML v2 Book

- Category: Methodology
- Author: Tim Weilkiens
- Location: reference root, e.g. `$SYSML_KNOWLEDGE/sysml-v2-book/`
- License: licensed material, must not be redistributed with this repository

### OMG SysML v2 Specification

- Category: Language
- Author: Object Management Group
- Location: reference root, e.g. `$SYSML_KNOWLEDGE/sysml-v2-specification/`
- Public source: <https://www.omg.org/spec/SysML/>

## Use by AI Agents

When consulting the reference library:

1. Identify the question to be answered.
2. Select the appropriate type of reference.
3. Consult the relevant source rather than relying on prior model knowledge.
4. Distinguish statements supported by a source from interpretations.
5. Cite the relevant source when deriving methodological guidance or making a consequential modeling decision.
6. Do not modify reference material.

Reference material should be retrieved as needed. It should not be copied wholesale into prompts, project instructions, or the product-specific method.

## Licensing

Access to reference material does not imply permission to redistribute it.

Licensed books and other restricted material must remain outside this repository unless their license explicitly permits inclusion. Project documentation should reference such material rather than reproduce it.
