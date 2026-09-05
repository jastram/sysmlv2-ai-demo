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

Large or licensed reference material should normally remain outside this repository.

Local references should be accessible through a configurable reference root rather than machine-specific absolute paths. For example:

```text
$SYSML_KNOWLEDGE/
├── sysmod/
├── sysml-v2-book/
├── sysml-v2-specification/
└── syside/
```

AI agents working on this repository should be given read access to this location when reference material is required.

Public Git repositories may alternatively be included as Git submodules when pinning the exact source revision is useful for reproducibility.

## Reference Manifest

For each reference used by the project, record:

* title;
* author or organization;
* version, edition, or Git revision where applicable;
* category: methodology, language, or tooling;
* local location or public source;
* licensing restrictions where relevant.

Example:

```markdown
### SYSMOD for SysML v2

- Category: Methodology
- Author: Tim Weilkiens / MBSE4U
- Version: <Git revision>
- Location: `$SYSML_KNOWLEDGE/sysmod/`
- Public source: <repository URL>
```

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
