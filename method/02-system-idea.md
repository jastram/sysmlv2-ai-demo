# System Idea

Guidance for activity 2 of [`00-development-process.md`](00-development-process.md).

This activity commits to the kind of solution that will be developed, and records the commitment. It does not design the system and it does not produce requirements.

```text
Source: SYSMOD for SysML v2, step 6 "System Idea"
Source: SYSMOD.sysml, systemIdeaContextAI create_prompt
Source: The SysML v2 Book, Section 14.1 "Base Architecture"
````

## Purpose

Activity 3 draws the system boundary. That cannot be done without knowing what kind of thing the system is: a device that cools by moving air has a power source at its boundary, one that cools by evaporation has a water supply and someone to refill it. The same needs, the same problem, different contexts.

This activity makes that commitment once, explicitly, so that the context of activity 3 has a stated basis and the commitment can be challenged as a whole rather than discovered scattered through the model.

The system idea is the answer to the problem statement of activity 1. It is not the answer to the needs; the needs are addressed by the use cases of activity 3 and the requirements of activity 4.

## The System Idea

The system idea is an elevator pitch: a short paragraph that a reader outside the project can understand, describing what the system is and how it delivers the effect the problem statement asks for.

The system idea:

* names the kind of system and the mechanism by which it produces its effect;
* stays at the level at which alternatives are still visible;
* says nothing about internal structure, components, interfaces, or technologies beyond what the commitment itself fixes.

The test for the right level: if a statement could be removed and activity 3 could still draw the boundary, it does not belong here. If activity 5 could still decide it freely, it does not belong here either.

```text
Source: SYSMOD.sysml, systemIdeaContextAI validation_prompt, on premature architecture detail
```

Name the system of interest after what it is for, not after how it works, as in activity 3. The mechanism belongs in the documentation and in the decisions, not in the name; the name survives a change of mechanism.

## Actors Introduced by the Commitment

A commitment puts entities at the system boundary that the problem alone does not imply. Model those actors here, and only those.

An actor belongs in this activity if removing the commitment would remove the actor. Every other actor is identified in activity 3.

This is the load-bearing output of the activity: it is what makes the context of activity 3 derivable rather than invented.

## Decisions

Record every choice that narrows the solution space, following the convention of [`00-development-process.md`](00-development-process.md).

A decision states:

| Field          | Content                                                      |
| -------------- | ------------------------------------------------------------ |
| `id`           | `D-nn`, assigned once and never reused                       |
| `status`       | `proposed`, `accepted`, or `superseded`                      |
| `rationale`    | Why this choice, in terms of the problem statement and needs |
| `alternatives` | What was rejected, and why                                   |

Attach the decision to the element it produced: the system of interest if it determines what the system is, the actor if it is what puts that actor at the boundary.

A decision whose rejected alternatives cannot be named is not a decision of this activity. Either it was already fixed by the project frame, or it is a solution detail belonging to activity 5.

## Assumptions

Record what the commitment relies on and the project does not control: properties of the workplace, of the actors, and of what they supply.

An assumption states what follows if it is false. Attach it to the element that relies on it.

Assumptions are not requirements. A requirement is something the system must achieve; an assumption is something the system is entitled to rely on. From activity 4 on, an assumption that a requirement depends on is additionally formalized as an `assume constraint` of that requirement.

```text
Source: OMG SysML v2 Specification, Section 7.21.2, on assumed constraints of requirements
```

## SysML v2 Representation

The activity produces one system idea context, one black-box definition of the system of interest, and one decision or assumption record per choice or reliance.

### System Idea Context

Define the context with `#systemContext`, which makes it a `SystemContext` and provides the inherited `soi`, `actors`, `asis`, and `useCases` features. Activity 3 specializes this context into the specification context.

```sysml
#systemContext part def DeskCoolingSystemIdeaContext {
    #System part deskCoolingSystem : DeskCoolingSystem :>> soi;

    #ExternalSystem part <name> :> actors {
        doc /* ... Present as an actor because of decision D-nn. */
        port <name>;
    }

    interface <name> :> asis connect <actor>.<port> to deskCoolingSystem.<port>;
}

part def DeskCoolingSystem {
    doc /* <the elevator pitch> */
    port <name>;
}
```

```text
Source: SYSMOD.sysml, SystemContext, System, ExternalSystem
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemIdea.sysml
```

### Decisions and Assumptions

Define the record types once, then annotate the model elements with them.

```sysml
metadata def Decision {
    attribute id : ScalarValues::String;
    attribute status : DecisionStatusKind default DecisionStatusKind::accepted;
    attribute rationale : ScalarValues::String;
    attribute alternatives : ScalarValues::String;
}
```

```sysml
metadata <id> : Decision about <Element> {
    id = "D-nn";
    rationale = "...";
    alternatives = "...";
}
```

Annotating from outside keeps the records in one register that can be read and rendered on its own, while the `about` relationship still attaches each record to its element.

```text
Source: OMG SysML v2 Specification, Section 7.24 "Metadata"
Source: SYSMOD.sysml, metadata ... about ..., as used by the AI metadata
```

### Project

Add the context to the project by redefining the inherited `systemIdeaContext` usage, and satisfy the problem statement with the system of interest.

```sysml
part deskCoolingIdeaContext :>> systemIdeaContext : DeskCoolingSystemIdeaContext {
    part deskCoolingSystem :>> deskCoolingSystem, Project::systemIdeaContext::soi {
        satisfy PRJ::problemStatement;
    }
}
```

```text
Source: SYSMOD.sysml, Project::systemIdeaContext
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemProject.sysml
```

### Subject of the Problem Statement and the Needs

Activity 1 left the subject of the problem statement, of the needs collection, and of each need undetermined. This activity gives them their type.

In each need definition:

```sysml
subject systemOfInterest : DeskCoolingSystem;
```

In the project, bind the inherited `brownfieldSystem` subject of the problem statement and of the needs collection to the system of interest:

```sysml
subject :>> brownfieldSystem = deskCoolingIdeaContext.deskCoolingSystem;
```

Activity 3 gives the subject of the individual needs its value, once the specification system exists.

The problem statement and the needs themselves are not reformulated. Only their subject is determined.

## Project-Specific Tailoring

**Black box only.**
SYSMOD develops the system idea as both a black-box context and a white-box `systemIdeaContextImpl` carrying a rough internal structure. This project develops the black box only. For a product this small the rough structure would be the architecture of activity 5, written a step early and with less information. The inherited `systemIdeaContextImpl` usage is left undeveloped, and the `satisfy` relationship to the problem statement that SYSMOD places on the white-box system is placed on the black-box system instead.

**No brownfield context.**
See the tailoring decision of the same name in [`00-development-process.md`](00-development-process.md). The system idea context does not specialize a brownfield context.

**Minimal actor set.**
Only actors forced by the commitment are modeled here. SYSMOD permits the system idea to add actors freely; keeping the set minimal keeps the split between this activity and activity 3 checkable.

**Decisions and assumptions modeled, not written as prose files.**
The model is the single source of truth for this repository, so records live in the model and can be rendered from it, rather than in separate decision-record documents.

## Traceability

At the end of this activity:

* a system idea context exists with the system of interest as a black box;
* the system of interest satisfies the problem statement;
* every actor in the context is there because of a recorded decision;
* every decision names its rejected alternatives and is attached to the element it produced;
* every assumption states the consequence of being false and is attached to the element that relies on it;
* the subject of the problem statement and of the needs is determined;
* no use cases, requirements, or internal structure exist yet.

Activity 3 specializes this context into the specification context and adds the remaining actors and the use cases.
