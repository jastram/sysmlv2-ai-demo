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

| # | Activity                     | Result                                                     |
| - | ---------------------------- | ---------------------------------------------------------- |
| 1 | Stakeholders and Needs       | Relevant stakeholders and their needs                      |
| 2 | System Context and Use Cases | System boundary, actors, and required interactions         |
| 3 | System Requirements          | Verifiable requirements traced to needs                    |
| 4 | System Architecture          | Behavior and structure that satisfy the requirements       |
| 5 | Verification and Validation  | Evidence that requirements are met and needs are addressed |

The project frame is considered given. It is defined by the repository and the project description: a small greenfield educational product with no existing architecture.

Activities 1 to 3 describe the problem space. Solution decisions are introduced during architecture development.

## Sequence

```text
Project Frame
   (given)
      |
1 Stakeholders and Needs
      |
2 System Context and Use Cases
      |
3 System Requirements
      |
4 System Architecture
      |
5 Verification and Validation
```

The sequence represents dependencies, not gates. Later work may reveal gaps that require returning to an earlier activity.

## Tailoring Decisions

**Project frame is given.**
A separate project-framing activity would add little value to this example. The development context and scope are already defined.

**System idea omitted.**
No explicit early solution concept is created. This avoids introducing unnecessary solution assumptions before the problem space has been understood.

**System context and use cases combined.**
For this small product, identifying the system boundary, external actors, and their required interactions belongs to one compact development activity.

**Minimal architecture development.**
Architecture is treated as one development activity. Separate functional, logical, or physical architecture stages are introduced only if they help answer an engineering question that arises during development.

```text
Source: The SysML v2 Book, Chapter 14 "A Simple Example"
```

**Continuous traceability.**
Traceability is established as artifacts are created rather than as a separate process activity. Requirements are related to their originating needs, architecture elements to the requirements they address, and verification results to the requirements they verify.

**Regulatory compliance is out of scope.**
The example does not attempt to demonstrate regulatory engineering or product certification.

**Reduced verification and validation.**
Verification and validation demonstrate the relationship from needs through requirements and architecture to evidence. A complete verification and validation programme is outside the scope of this educational example.

