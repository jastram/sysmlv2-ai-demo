# Stakeholders and Needs

Guidance for activity 1 of [`01-development-process.md`](01-development-process.md).

This activity identifies relevant stakeholders and their needs. It does not produce system requirements. It is a tailored merge of SYSMOD steps 3 and 4.

```text
Source: SYSMOD for SysML v2, steps 3 "Stakeholders" and 4 "Stakeholder Needs"
````

## Stakeholders

A stakeholder is an individual, group, or organization with an interest in the system or affected by it. Model stakeholder roles, not individuals.

```text
Source: The SysML v2 Book, Section 32.1 "Stakeholders"
```

Identify stakeholders by asking:

| Question                             | Category           |
| ------------------------------------ | ------------------ |
| Who interacts with the system?       | `user`             |
| Who decides what the system must do? | `requirementOwner` |
| Who holds relevant domain knowledge? | `expert`           |
| Who is affected without interacting? | `other`            |

The categories are `StakeholderCategoryKind` from the SYSMOD library. A stakeholder may have several categories.

Keep the set small, about five at most. Do not model stakeholders separately if they contribute no distinct needs.

For each stakeholder, set:

* `risk`: consequence of overlooking the stakeholder;
* `effort`: effort required to elicit their needs.

Both use `LevelKind`. `priority` is derived by the SYSMOD library.

## Needs

A need is a desired outcome regarding the system, expressed from a stakeholder's perspective.

A need:

* belongs to at least one stakeholder;
* describes what the stakeholder wants, not how it is achieved;
* does not need to be verifiable yet.

Use one sentence:

```text
<stakeholder> needs <outcome> so that <purpose>.
```

The purpose helps expose hidden solution assumptions. If the same purpose could be achieved through a different mechanism and the need would no longer apply, reformulate the need at the level of the purpose.

Do not name components, technologies, or physical mechanisms. For this product, terms such as fan, motor, sensor, camera, servo, controller, or specific cooling technology do not belong in a need unless the stakeholder genuinely requires that particular solution.

Give each need a `priority` using `LevelKind`.

```text
Source: SYSMOD for SysML v2, stakeholder-needs guidance
Source: SYSMOD.sysml, stakeholderNeedsAI create_prompt
```

System requirements are derived from the needs in activity 3.

## SysML v2 Representation

SysML v2 has no dedicated stakeholder element. Stakeholders are represented as parts. Needs are represented as concerns.

```text
Source: The SysML v2 Book, Sections 32.1 and 32.5
Source: OMG SysML v2 Specification, Section 7.21.1 "Requirements Overview"
Source: OMG SysML v2 Specification, Section 7.21.3 "Concern Definitions and Usages"
```

### Stakeholders

Define each stakeholder using `ExtendedStakeholder` and add it to `projectStakeholders`.

```sysml
#extendedStakeholder part def DeskWorker {
    doc /* ... */

    attribute :>> risk = LevelKind::high;
    attribute :>> effort = LevelKind::low;
    attribute :>> categories = StakeholderCategoryKind::user;
}
```

### Needs

Define each need using `ExtendedConcern`, include the need sentence as documentation, and declare its stakeholder.

```sysml
#extendedConcern concern def <NeedName> {
    doc /* <stakeholder> needs <outcome> so that <purpose>. */

    stakeholder <role> : <StakeholderDefinition>;

    attribute :>> priority = LevelKind::<level>;
}
```

Add the stakeholder usages to `projectStakeholders` and the need usages to `stakeholderNeeds`.

```text
Source: SYSMOD.sysml, ExtendedStakeholder, ExtendedConcern,
        Project::projectStakeholders, Project::stakeholderNeeds
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemStakeholders.sysml
```

## Project-Specific Tailoring

**Explicit stakeholder links.**
Each need declares its stakeholder. The SYSMOD delivery-drone example does not make this relationship explicit, but SysML v2 concerns provide a `stakeholder` parameter for this purpose.

```text
Source: OMG SysML v2 Specification, Section 7.21.3
```

**No subject yet.**
The system of interest is established during activity 2, so stakeholder needs do not declare a subject at this stage.

**No contact information.**
Stakeholders are modeled as roles rather than named people.

**No stakeholder priority map.**
The SYSMOD-derived `priority` attribute is sufficient for this example.

## Traceability

At the end of this activity:

* every need identifies at least one stakeholder;
* every modeled stakeholder contributes at least one need, unless documented otherwise;
* no links to requirements, use cases, or architecture exist yet.

Further traceability is added when those artifacts are created.
