# Problem, Stakeholders and Needs

Guidance for activity 1 of [`00-development-process.md`](00-development-process.md).

This activity states the problem the project exists to solve, identifies the relevant stakeholders, and captures their needs. It does not produce system requirements and does not commit to a solution. It is a tailored merge of SYSMOD steps 2, 3 and 4.

```text
Source: SYSMOD for SysML v2, steps 2 "Problem Statement", 3 "Stakeholders" and 4 "Stakeholder Needs"
````

## Problem Statement

The problem statement is one paragraph that says what the project is for. It is the element the system idea of activity 2 is justified against, and the element the stakeholder needs frame.

A problem statement:

* describes a situation that is unsatisfactory, and for whom;
* says what would make it satisfactory;
* names no solution, no mechanism, and no technology.

The project owner owns the problem statement. The project owner is one of the stakeholders identified below.

SYSMOD writes the problem statement against the existing system and its deficiencies. This project is greenfield, so it is written against the situation at an ordinary workplace today.

```text
Source: SYSMOD.sysml, Project::problemStatement
Source: SYSMOD.sysml, problemStatementAI create_prompt
```

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

Exactly one stakeholder is the project owner: the role accountable for the project and for resolving conflicts between the other stakeholders.

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

System requirements are derived from the needs in activity 4.

## SysML v2 Representation

SysML v2 has no dedicated stakeholder element. Stakeholders are represented as parts. The problem statement and the needs are represented as concerns.

```text
Source: The SysML v2 Book, Sections 32.1 and 32.5
Source: OMG SysML v2 Specification, Section 7.21.1 "Requirements Overview"
Source: OMG SysML v2 Specification, Section 7.21.3 "Concern Definitions and Usages"
```

### Stakeholders

Define each stakeholder using `ExtendedStakeholder` and add it to `projectStakeholders`. The project owner redefines the inherited `projectOwner` usage instead.

```sysml
#extendedStakeholder part def DeskWorker {
    doc /* ... */

    attribute :>> risk = LevelKind::high;
    attribute :>> effort = LevelKind::low;
    attribute :>> categories = StakeholderCategoryKind::user;
}
```

```sysml
part <role> : <StakeholderDefinition> :>> projectOwner;
```

### Problem Statement

Redefine the inherited `problemStatement` usage in the project.

```sysml
concern :>> problemStatement {
    doc /* <the problem statement> */
}
```

Its stakeholder is inherited: the library binds it to the project owner.

### Needs

Define each need using `ExtendedConcern`, include the need sentence as documentation, and declare its stakeholder.

```sysml
#extendedConcern concern def <NeedName> {
    doc /* <stakeholder> needs <outcome> so that <purpose>. */

    subject systemOfInterest;

    stakeholder <role> : <StakeholderDefinition>;

    attribute :>> priority = LevelKind::<level>;
}
```

Add the stakeholder usages to `projectStakeholders` and the need usages to `stakeholderNeeds`. The needs frame the problem statement; make that inherited relationship concrete.

```sysml
concern :>> stakeholderNeeds {
    frame problemStatement :>> Project::stakeholderNeeds::problemStatement :> PRJ::problemStatement;

    concern <needName> : <NeedDefinition>;
}
```

```text
Source: SYSMOD.sysml, ExtendedStakeholder, ExtendedConcern,
        Project::projectOwner, Project::problemStatement,
        Project::projectStakeholders, Project::stakeholderNeeds
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemStakeholders.sysml
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemProject.sysml
```

## Project-Specific Tailoring

**Explicit stakeholder links.**
Each need declares its stakeholder. The SYSMOD delivery-drone example does not make this relationship explicit, but SysML v2 concerns provide a `stakeholder` parameter for this purpose.

```text
Source: OMG SysML v2 Specification, Section 7.21.3
```

**Subject declared but not yet determined.**
The system of interest is committed to in activity 2, so this activity does not identify a system. The subject parameter is nevertheless declared, without a type and without a binding, because a concern definition that declares a stakeholder must declare its subject as the first parameter. Activity 2 gives the subject its type, activity 3 its value.

```text
Source: OMG SysML v2 Specification, Section 7.21.2 "Requirement Definitions and Usages"
Source: Syside rule requirement-definition-subject-parameter-position
```

**Problem statement and needs are not anchored to a brownfield system.**
SYSMOD anchors the subject of the problem statement and of the stakeholder needs to the white-box brownfield system. This project develops no brownfield context, so the inherited `brownfieldSystem` subject is bound to the system of interest in activity 2 instead. The library name of the feature is kept.

```text
Source: 00-development-process.md, tailoring decision "No brownfield context"
```

**No contact information.**
Stakeholders are modeled as roles rather than named people. The project owner is therefore a role as well, unlike the named project owner of the SYSMOD delivery-drone example.

**No stakeholder priority map.**
The SYSMOD-derived `priority` attribute is sufficient for this example.

## Traceability

At the end of this activity:

* a problem statement exists, is free of solution terms, and has the project owner as its stakeholder;
* exactly one stakeholder redefines `projectOwner`;
* every need identifies at least one stakeholder;
* every modeled stakeholder contributes at least one need, unless documented otherwise;
* the needs frame the problem statement;
* no links to a system, requirements, use cases, or architecture exist yet.

Further traceability is added when those artifacts are created.
