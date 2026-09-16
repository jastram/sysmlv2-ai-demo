# Development Process

This document defines the development process for the intelligent desk cooling device.

It defines only the main activities, their sequence, and the important tailoring decisions. Detailed guidance for individual activities is added in separate method documents as the development progresses.

## Basis and Tailoring

The process is a tailored subset of SYSMOD v5.

The purpose of the modeling is educational: demonstrating AI-assisted systems engineering with SysML v2 on a small greenfield product. Activities and artifacts that do not contribute to this purpose are omitted.

```text
Source: SYSMOD for SysML v2, SYSMOD v5
Source: The SysML v2 Book, Section 4.2 "Harmonic Triad of Modeling"
````

## Activities

| # | Activity                        | Result                                                          |
| - | ------------------------------- | --------------------------------------------------------------- |
| 1 | Problem, Stakeholders and Needs | The problem to be solved, the relevant stakeholders, their needs |
| 2 | System Idea                     | The solution commitment, and the system boundary it establishes  |
| 3 | System Context and Use Cases    | What crosses the boundary, and the required interactions         |
| 4 | System Requirements             | Verifiable requirements traced to needs                          |
| 5 | System Architecture             | Behavior and structure that satisfy the requirements             |
| 6 | Verification and Validation     | Evidence that requirements are met and needs are addressed       |

The project frame is considered given. It is defined by the repository and the project description: a small greenfield educational product with no existing architecture.

Activity 1 describes the problem. Activity 2 commits to the kind of solution that will be developed. Activities 3 onward describe that solution in increasing detail.

## Why the Solution Commitment Comes Before the Context

The system context is not solution-independent. Different solutions to the same problem put different actors at the system boundary: a device that cools by moving air needs a power source, one that cools by evaporation needs a water supply and someone to refill it. The boundary cannot be drawn before the kind of solution is fixed.

The commitment is therefore made deliberately in activity 2 and recorded, rather than entering the model unnoticed through the context. Everything downstream is valid relative to that commitment and has to be revisited if it changes.

```text
Source: The SysML v2 Book, Section 14.1 "Base Architecture"
Source: SYSMOD for SysML v2, step 6 "System Idea"
```

## Sequence

```text
Project Frame
   (given)
      |
1 Problem, Stakeholders and Needs
      |
2 System Idea
      |
3 System Context and Use Cases
      |
4 System Requirements
      |
5 System Architecture
      |
6 Verification and Validation
```

The sequence represents dependencies, not gates. Later work may reveal gaps that require returning to an earlier activity.

## Decisions and Assumptions

Development narrows the solution space. Neither SYSMOD nor SysML v2 provides an element for recording how. *The SysML v2 Book* records architecture and technology decisions in the base architecture itself; this project follows that principle and attaches each record to the model element it produced or constrains, so that a decision cannot be found without its element, and an element cannot be read without its decisions.

Two kinds are distinguished:

| Kind           | Question it answers                                            | Recorded on                       |
| -------------- | -------------------------------------------------------------- | --------------------------------- |
| **Decision**   | Which of several possible solutions did we choose, and why?     | The element the choice produced   |
| **Assumption** | What do we rely on that we do not control and have not checked? | The element that relies on it     |

A decision names the alternatives it rejected. A record without rejected alternatives is not a decision, it is a description.

An assumption states what follows if it turns out to be false. From activity 4 on, an assumption that a requirement depends on is additionally formalized as an `assume constraint` of that requirement. Until then it is documented.

Both are traced by dependencies, in addition to annotating their element:

| From | To | Meaning |
| ---- | -- | ------- |
| A decision | The stakeholder needs it serves | The decision exists to serve these; if they change, it is reopened |
| A decision | The assumptions it rests on | The decision holds only while these hold |

The dependency always runs from the dependent element to what it rests on. Following it forwards answers "why is this so?"; following it backwards answers "what breaks if this changes?". A decision that traces to no need is a decision nobody asked for.

Both are modeled as metadata annotating the element, with plain SysML v2 dependencies for the traces, in [`../model/DeskCoolingDecisions.sysml`](../model/DeskCoolingDecisions.sysml). Identifiers are `D-nn` and `A-nn` and are never reused. A decision that no longer holds is marked `superseded` and kept rather than deleted.

```text
Source: The SysML v2 Book, Section 14.1, on recording architecture and technology decisions
Source: OMG SysML v2 Specification, Section 7.21.2, on assumed constraints of requirements
Source: OMG SysML v2 Specification, Section 7.5 "Dependencies"
```

## Modeling Conventions

**Named redefinitions.**
A redefinition that supplies a value or a body — an attribute value, a constraint — is given a name, repeating the name of the feature it redefines:

```sysml
attribute risk :>> risk = LevelKind::high;
constraint precondition :>> precondition { doc /* ... */ }
```

SysML v2 also allows the shorter anonymous form, `attribute :>> risk = ...`, which SYSMOD and the standard library both use. It leaves the usage without a name of its own. A tool that needs a label then has only the implicit base feature to fall back on, so several attributes redefined in the same element all render as `dataValues`, and a precondition and a postcondition both render as `constraintChecks` — indistinguishable in any generated view. Naming the redefinition costs one word and removes the ambiguity.

The convention applies where a value or a body is supplied. Structural redefinitions that carry their own declaration, such as a redefined port or part, already have a name or are unique within their element, and are left in the short form.

## Tailoring Decisions

**Project frame is given.**
A separate project-framing activity would add little value to this example. The development context and scope are already defined.

**Problem statement retained.**
The problem statement is the one-paragraph, solution-free statement of what the project is for. It is the element that the system idea is justified against, so it is developed in activity 1 together with the needs, which frame it.

**System idea retained.**
An earlier version of this process omitted the system idea in order to keep the problem space free of solution decisions. That is not achievable: the system context already embodies a solution commitment, so omitting the system idea does not remove the commitment, only its record. SYSMOD provides the system idea for exactly this purpose, and *The SysML v2 Book* calls the same artifact the base architecture.

The system idea is kept to a black-box commitment. It must not anticipate the internal structure developed in activity 5.

**No brownfield context.**
SYSMOD derives the system idea from a brownfield context, in which the system idea specializes the existing system of interest. This project is greenfield: there is no predecessor system of the same kind, and specializing one would assert a relationship that does not exist. The inherited `brownfieldContext` and `brownfieldContextImpl` usages are left undeveloped and the system idea context is developed directly. What a brownfield context would have carried — the properties of the workplace that the system has to live with — is recorded as assumptions instead.

**System context and use cases combined.**
For this small product, identifying the system boundary, external actors, and their required interactions belongs to one compact development activity.

**Minimal architecture development.**
Architecture is treated as one development activity. Separate functional, logical, or physical architecture stages are introduced only if they help answer an engineering question that arises during development.

```text
Source: The SysML v2 Book, Chapter 14 "A Simple Example"
```

**Continuous traceability.**
Traceability is established as artifacts are created rather than as a separate process activity. Needs frame the problem statement, the system idea satisfies it, requirements are related to their originating needs, architecture elements to the requirements they address, and verification results to the requirements they verify.

**Regulatory compliance is out of scope.**
The example does not attempt to demonstrate regulatory engineering or product certification.

**Reduced verification and validation.**
Verification and validation demonstrate the relationship from needs through requirements and architecture to evidence. A complete verification and validation programme is outside the scope of this educational example.
