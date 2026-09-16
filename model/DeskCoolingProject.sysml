package <DCD> DeskCooling {
    doc
    /* The SYSMOD project of the intelligent desk cooling device.
     *
     * The project is the shared context that links the engineering artifacts.
     * At this stage it contains the results of activity 1 (problem statement,
     * stakeholders, needs), activity 2 (system idea) and activity 3
     * (specification context and use cases). Further artifacts are added by
     * the later activities of method/00-development-process.md.
     */

    private import SYSMOD::*;
    private import DCD_STAKEHOLDERS::*;
    private import DCD_STAKEHOLDERNEEDS::*;

    #project occurrence def <PRJ> 'Desk Cooling Project' {
        doc
        /* Project frame: a small greenfield educational demonstrator for an
         * intelligent desk cooling device. The frame is given by the repository
         * and is not developed as a modeling activity. */

        //------------------------- Stakeholders
        part deskWorker : DeskWorker :> projectStakeholders;
        part officeNeighbor : OfficeNeighbor :> projectStakeholders;
        part productManager : ProductManager :>> projectOwner;

        //------------------------- Problem Statement
        concern :>> problemStatement {
            doc
            /* People who work at a desk become too warm at their workplace
             * often enough that it costs them concentration and comfort, and
             * they have no means of their own to do anything about it. The
             * conditions of the room are set for everyone in it, so making one
             * person comfortable today makes another person less so. The
             * project is to give an individual desk worker relief at their own
             * workplace, without preparation of the workplace, without taking
             * their attention away from their work, and without making the
             * workplace worse for the people around them.
             *
             * The problem statement is solution-free. Activity 2 answers it
             * with the system idea. */

            subject :>> brownfieldSystem = deskCoolingIdeaContext.deskCoolingSystem;
        }

        //------------------------- Stakeholder Needs
        concern :>> stakeholderNeeds {
            doc
            /* The stakeholder needs frame the problem statement. Activity 2
             * "System Idea" gave their subject its type; activity 3 binds it to
             * the specification system. */

            subject :>> brownfieldSystem = deskCoolingIdeaContext.deskCoolingSystem;
            frame problemStatement :>> Project::stakeholderNeeds::problemStatement :> PRJ::problemStatement;

            concern thermalRelief : ThermalRelief {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern comfortWithoutAttention : ComfortWithoutAttention {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern simpleUseAndControl : SimpleUseAndControl {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern undisturbedSharedWorkspace : UndisturbedSharedWorkspace {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern privacyOfPeopleNearby : PrivacyOfPeopleNearby {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern safeNearbyUse : SafeNearbyUse {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
            concern fitsOrdinaryWorkplaces : FitsOrdinaryWorkplaces {
                subject :>> systemOfInterest :> deskCoolingContext.deskCoolingSystem;
            }
        }

        //------------------------- System Idea
        part deskCoolingIdeaContext :>> systemIdeaContext : DCD_IDEA::DeskCoolingSystemIdeaContext {
            doc
            /* The system idea context. The brownfield context is not developed,
             * so this context does not specialize one. */

            part deskCoolingSystem :>> deskCoolingSystem, Project::systemIdeaContext::soi {
                doc
                /* The system idea is the answer to the problem statement. */

                satisfy PRJ::problemStatement;
            }
        }

        //------------------------- Specification Context and Use Cases
        part deskCoolingContext :>> specificationContext : DCD_CONTEXT::DeskCoolingSystemContext :> deskCoolingIdeaContext {
            doc
            /* The specification context. It specializes the system idea context
             * and owns the system use cases. */

            part deskCoolingSystem :>> deskCoolingSystem, deskCoolingIdeaContext::deskCoolingSystem, Project::specificationContext::soi;
        }
    }
}
