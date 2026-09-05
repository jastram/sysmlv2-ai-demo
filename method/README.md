# Product-Specific Development Method

This directory contains the development method tailored to this product.

The method guides both human engineers and AI agents. It defines how the system model is developed, which engineering activities are performed, and which modeling conventions apply.

The method is intentionally developed incrementally. It should contain only guidance that is relevant to the current product and its development.

## Sources of Knowledge

The method is derived from external reference material. The reference library is maintained separately from this repository.

The available sources and their versions are documented in [`../references.md`](../references.md).

Different sources have different authority:

1. **Project method**
   The files in this directory define the method and conventions selected for this product.

2. **Product-class guidance, if available**
   Defines reusable guidance for this organization and class of products.

3. **Method references**
   Sources such as SYSMOD and *The SysML v2 Book* provide methodological guidance and rationale.

4. **Language references**
   The OMG SysML v2 specification is authoritative for SysML v2 language semantics.

5. **Tool references**
   Syside documentation is authoritative for tool-specific behavior and capabilities.

These sources answer different questions. Language validity does not imply methodological suitability.

## Contents

The method starts small and grows with the development.

At minimum, it should eventually describe:

* the development activities and their sequence;
* expected inputs and outputs of each activity;
* completion criteria where useful;
* modeling conventions used by this product;
* relevant tool and CI conventions.

Detailed guidance should be added only when it becomes relevant.

## Developing the Method

Before starting a new development activity:

1. Determine whether the existing product method already provides sufficient guidance.
2. If necessary, consult the relevant external references.
3. Tailor the guidance to the needs of this product.
4. Document the resulting guidance in this directory.
5. Reference the sources from which important methodological decisions were derived.
6. Review the new or changed method before applying it to the system model.

Do not copy large sections of reference material into this directory. Capture the resulting product-specific guidance and reference its source instead.

## Resolving Method Questions

When a methodological question arises during modeling, use the following order:

1. Apply existing product-specific guidance if it covers the question.
2. Consult product-class guidance if available.
3. Consult the relevant methodological references.
4. Consult the SysML v2 specification when language semantics are involved.
5. Consult Syside documentation when tool behavior is involved.
6. Record a reusable conclusion in the product method.
7. Record a one-off or context-specific choice as an engineering decision instead.

Do not silently introduce new methodological conventions into the model.

## Traceability

Method guidance should be traceable to its basis where this helps understand or challenge a decision.

A reference should identify the source precisely enough to find the relevant material, for example:

```text
Source: SYSMOD for SysML v2, <section>
Source: The SysML v2 Book, <chapter/section>
Source: OMG SysML v2 Specification, <section>
```

References explain the basis of the tailored method. They do not replace the product-specific guidance in this directory.

## Initial State

At the start of development, this directory intentionally contains little more than this README.

The first task is to determine the minimum method required for the first engineering activity. The method and the system model then evolve together, with methodological guidance established before it is relied upon in the model.
