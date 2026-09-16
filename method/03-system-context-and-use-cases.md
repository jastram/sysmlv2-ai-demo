# System Context and Use Cases

Guidance for activity 3 of [`00-development-process.md`](00-development-process.md).

This activity details the interactions across the system boundary established in activity 2 and describes the interactions the system must support as use cases. It does not produce system requirements and does not decide how the system works internally.

It is a tailored version of the SYSMOD specification context, combining the system context and the use cases into one activity.

```text
Source: SYSMOD for SysML v2, step 7 "Specification Context"
Source: SYSMOD.sysml, specificationContextAI create_prompt
Source: The SysML v2 Book, Sections 14.2 "System Context" and 14.4 "Use Cases"
````

The system context is a methodical concept. SysML v2 provides no dedicated element for it.

```text
Source: The SysML v2 Book, Section 14.2
```

## System Boundary

The system of interest is what this project develops. Everything that interacts with it and is not developed by this project is an actor.

The boundary is not drawn from scratch. Activity 2 committed to a kind of solution and produced a complete black-box context: the system of interest and every actor that interacts with it. This activity specializes that context and determines what actually crosses each interface.

Deciding what crosses the boundary is the main decision of this activity. It determines what the system is accountable for and what it may assume about its surroundings.

The system of interest is modeled as a black box. It has external ports and no internal structure. Internal structure is introduced in activity 5.

Name the system of interest after what it is, not after how it works. `DeskCoolingSystem` is acceptable; a name containing a mechanism is not.

## Actors

The actors are established in activity 2. This section is the check that the set is right, not an invitation to start over.

An actor is an external entity that interacts with the system: a person, another system, or an environmental effect.

```text
Source: SYSMOD.sysml, SystemContext::actors
```

Identify actors by asking:

| Question                                          | Category                |
| ------------------------------------------------- | ----------------------- |
| Who operates the system or receives its effect?   | `#User`                 |
| Which external system does it depend on or serve? | `#ExternalSystem`       |
| Which environmental condition acts on it?         | `#EnvironmentalEffect`  |

An entity that only receives an effect is still an actor. It does not have to command the system.

Actors are inherited from the system idea context and are not repeated. If this activity reveals an actor the system idea missed, add it there, with the decision that puts it at the boundary if one does, rather than here: the boundary belongs to one artifact.

Keep the set small, about five at most. Model an actor separately only if it crosses the boundary in its own way.

### Actors and Stakeholders

Actors and stakeholders are different concepts and are modeled separately.

A stakeholder holds an interest in the system. An actor occupies a role at the system boundary. They frequently correspond, but not always: a stakeholder may never interact with the system, and an actor may hold no interest of its own.

Where an actor corresponds to a stakeholder from activity 1, name the stakeholder in the actor's documentation.

Every `#User` actor should be covered by at least one stakeholder. A person at the boundary whom no stakeholder represents means either that a stakeholder was overlooked in activity 1, or that the entity is not really an actor.

The converse does not hold in either direction. A `#ExternalSystem` or `#EnvironmentalEffect` actor need not correspond to a stakeholder.

```text
Source: SYSMOD.sysml, projectStakeholdersAI validation_prompt, which states the
        stronger rule that every actor maps to a stakeholder; the SYSMOD
```

## Interactions

Every actor exchanges something with the system across the boundary. Activity 2 established the ports and the interfaces; this activity says what crosses them, by redefining the system's ports with the items they carry.

Describe what crosses the boundary at the level of the problem: an effect, an item, or information. Do not describe the mechanism that carries it.

Solution neutrality is relative to the system idea. What activity 2 committed to may be named here; everything beyond it may not. Terms such as motor, sensor, camera, servo, or controller name internal mechanisms that no decision has fixed, and do not belong in the context or in a use case. If a term seems necessary and is not covered by a decision of activity 2, that is a finding about activity 2, not a licence to introduce it here.

An actor that exchanges nothing across the boundary is not an actor.

## Use Cases

A use case describes the behavior of the system from an external perspective: an interaction between the system and one or more actors that produces an observable result of value.

```text
Source: The SysML v2 Book, Section 33.1 "Use Cases"
```

A use case:

* has the system of interest as its subject;
* names at least one actor;
* ends in a result that an actor can observe;
* stays outside the system, describing what is exchanged rather than how the system produces it.

For each use case, record:

| Element         | Content                                                        |
| --------------- | -------------------------------------------------------------- |
| `objective`     | What the use case achieves, in one or two sentences             |
| `ucMotivation`  | Why an actor initiates it                                       |
| `ucTrigger`     | The event at the system boundary that starts it                 |
| `ucResult`      | The outcome guaranteed on successful completion                 |
| `precondition`  | What must hold before it starts                                 |
| `postcondition` | What is guaranteed once it completes successfully               |

```text
Source: SYSMOD.sysml, SystemUseCase and ConstrainedOccurrence
```

Name a use case after the result, as a verb phrase: `ProvideRelief`, not `ReliefFunction`.

### Flows

Each use case records the sequence in which its exchanges happen, as an ordered flow of black-box actions of the system.

A flow states **what the system does, observed from outside**. It does not state how the system does it. `deliverRelief` is a black-box behavior; `spinRotor` is not, and neither is anything a decision of activity 2 has not fixed.

The actor's steps do not appear as actions. An actor's part in the interaction is visible in two places already: the `ucTrigger` says what the actor does to start it, and the `in` items of each action say what the actor supplies. Modeling the actor's steps as well would double the elements and require behaviors on actors that this project does not otherwise need.

```text
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemSpecification.sysml,
        whose use case flows subset actions of the black-box specification system
```

A flow stops where the use case's result is achieved. A step that is the trigger of another use case belongs to that use case, not to this one. Where one use case leaves the system in the state another requires, the postcondition of the first and the precondition of the second say so; no relationship between the use cases is modeled.

Keep a flow to a handful of steps. A flow long enough to need structuring is describing internal behavior, which belongs to activity 5.

Keep the set small, about five at most. A use case that no actor cares about is a system function, not a use case, and belongs to activity 5.

Each use case identifies the stakeholder needs it addresses. A need that no use case addresses is either satisfied by a property of the system rather than by an interaction, or the set of use cases is incomplete.

## SysML v2 Representation

The activity produces one system context definition, one black-box definition of the system of interest, and one use case definition per use case.

### System Context

Define the context with `#systemContext` as a specialization of the system idea context of activity 2. The actors and the interfaces are inherited; only the system of interest is redefined, and the use case usages are added.

```sysml
#systemContext part def DeskCoolingSystemContext :> DCD_IDEA::DeskCoolingSystemIdeaContext {
    #System part deskCoolingSystem :>> DCD_IDEA::DeskCoolingSystemIdeaContext::deskCoolingSystem : DeskCoolingSystem;

    use case <name> : UseCases::<UseCaseName> :> useCases { /* ... */ }
}

part def DeskCoolingSystem :> DCD_IDEA::DeskCoolingSystem {
    doc /* Black-box definition of the system of interest at specification level. */

    port :>> <portName> {
        out item <name> : <ItemDefinition>;
        in item <name> : <ItemDefinition>;
    }
}
```

```text
Source: SYSMOD.sysml, SystemContext, System, User, ExternalSystem, EnvironmentalEffect
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemBrownfieldArchitecture.sysml
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemProject.sysml
```

### Use Cases

Define each use case with `#systemUseCase`, in a `UseCases` package next to the context.

```sysml
#systemUseCase use case def <UseCaseName> {
    subject deskCoolingSystem : DeskCoolingSystem;

    actor <role>;

    objective {
        doc /* <what the use case achieves> */
        frame concern <needName> : <NeedDefinition>;
    }

    attribute ucMotivation :>> ucMotivation = "...";
    attribute ucTrigger :>> ucTrigger = "...";
    attribute ucResult :>> ucResult = "...";

    constraint precondition :>> precondition { doc /* ... */ }
    constraint postcondition :>> postcondition { doc /* ... */ }

    action <name> :> deskCoolingSystem.<name>;

    first start then <name>;
    first <name> then done;
}
```

The actions of the flow subset black-box actions declared on the system of interest, so that the same behavior used by two use cases is one element:

```sysml
part def DeskCoolingSystem :> DCD_IDEA::DeskCoolingSystem {
    action <name> {
        doc /* <what the system does, observed from outside> */
        in item <name> : <ItemDefinition>;
        out item <name> : <ItemDefinition>;
    }
}
```

The subject and the actors are parameters of the use case definition. The context owns the use case usages and binds those parameters to its own system and actors.

```sysml
use case <name> : UseCases::<UseCaseName> :> useCases {
    subject :>> deskCoolingSystem :> DeskCoolingSystemContext::deskCoolingSystem;
    actor :>> <role> :> DeskCoolingSystemContext::<actor>;
}
```

```text
Source: The SysML v2 Book, Sections 14.4 and 33.1
Source: OMG SysML v2 Specification, Section 7.25.2 "Use Case Definitions and Usages"
Source: OMG SysML v2 Specification, Section 7.22.2, on subject and actor parameters
```

### Project

Add the context to the project by redefining the inherited `specificationContext` usage, as a specialization of the system idea context usage.

```sysml
part deskCoolingContext :>> specificationContext : DeskCoolingSystemContext :> deskCoolingIdeaContext {
    part deskCoolingSystem :>> deskCoolingSystem, deskCoolingIdeaContext::deskCoolingSystem, Project::specificationContext::soi;
}
```

```text
Source: SYSMOD.sysml, Project::specificationContext
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemProject.sysml
```

### Subject of the Needs

Activity 2 gave the subject of each need its type. This activity gives it its value, now that the specification system exists.

In the project, give the need usage its value:

```sysml
concern <needName> : <NeedDefinition> {
    subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
}
```

The needs themselves are not reformulated. Only their subject is determined.

## Project-Specific Tailoring

**Specification context refined from the system idea.**
SYSMOD refines the context along a chain from the brownfield context through the system idea to the specification context. This project develops no brownfield context, so the chain starts at the system idea: the specification context specializes the system idea context, and the specification system specializes the system idea system.

```text
Source: 00-development-process.md, tailoring decisions "Project frame is given" and "No brownfield context"
```

**Black box only.**
This activity produces only the black-box context. The white-box `specificationContextImpl` is developed in activity 5, where internal structure is decided.

**Black-box flows, no actor actions.**
An earlier version of this guidance omitted use case flows entirely, on the grounds that the actions in the SYSMOD example describe internal behavior. That was wrong: those actions are declared on the black-box specification system, not on its implementation, and they state what the system does rather than how. Flows are therefore developed here, restricted to black-box actions of the system, with the actors' steps left to the trigger and the items.

Writing the flows is also what finds missing exchanges. The interface between the system and the desk worker gained the `ServiceIndication` item only because the flow of `PutIntoService` had no way to tell the desk worker that the system was ready.

```text
Source: SYSMOD for SysML v2, examples/DeliveryDroneSystemSpecification.sysml
Source: The SysML v2 Book, Section 33.1, on realizing use case events by system and actor behaviors
```

Activity 5 refines these flows once internal structure exists, by allocating each black-box action to the parts that perform it.

**Explicit need links.**
Each use case frames the needs it addresses as concerns of its objective. This makes the link from needs to required interactions checkable in the model rather than only in prose. It follows the explicit-stakeholder-link decision of activity 1.

```text
Source: OMG SysML v2 Specification, Section 7.21.3 "Concern Definitions and Usages", on framed concerns
```

**No domain library.**
The SYSMOD delivery-drone example maintains a separate domain library of shared items. For this small product, items that cross the system boundary are defined next to the context. A domain library is introduced only if items become shared between artifacts.

**Untyped actor parameters.**
The actors of activity 2 are untyped part usages, following the SYSMOD delivery-drone example, so there is no actor definition for a use case parameter to be typed by. The parameters are declared untyped and given their value by subsetting the context's actor. The SYSMOD example goes further and declares no actor parameters at all; this project keeps them, because a use case that cannot name its actors cannot be checked against the rule that every use case has one.

**Items on the system side only.**
What crosses an interface is declared on the system's ports. The actors' ports are left bare. For this product, declaring the same items a second time on the actor would state nothing new and would double the work of every later change.

**No include use cases.**
Use cases are kept independent. Shared behavior is factored out only if the same interaction genuinely appears in more than one use case.

**Needs without use cases documented in the use case package.**
A need that no interaction can address is recorded in the documentation of the use case package, with the reason, rather than left to be noticed as a gap. It becomes a system requirement in activity 4.

## Traceability

At the end of this activity:

* the system of interest is a black box with a port for every interaction across its boundary;
* every actor is connected to the system by at least one interface;
* every `#User` actor corresponds to at least one stakeholder, and every other actor is documented as needing none;
* every use case has the system of interest as its subject and names at least one actor;
* every use case frames at least one stakeholder need;
* every use case has a flow that starts at `start`, ends at `done`, and uses only black-box actions of the system;
* every exchange a flow needs has an item on the system's ports;
* every need is addressed by a use case, or documented as a need that no interaction can address;
* the subject of every need is bound to the specification system;
* no actor was added here that belongs in the system idea context;
* no requirements or architecture elements exist yet.

Requirements are derived from the needs and the use cases in activity 4.
