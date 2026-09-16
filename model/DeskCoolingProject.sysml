package <DCD> DeskCooling {
    doc
    /* The SYSMOD project of the intelligent desk cooling device.
     *
     * The project is the shared context that links the engineering artifacts.
     * At this stage it contains the results of activity 1 (problem statement,
     * stakeholders, needs) and activity 2 (system idea). Further artifacts are
     * added by the later activities of method/01-development-process.md.
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
            /* The stakeholder needs frame the problem statement. Their subject
             * is the system of interest committed to in activity 2 "System
             * Idea". */

            subject :>> brownfieldSystem = deskCoolingIdeaContext.deskCoolingSystem;
            frame problemStatement :>> Project::stakeholderNeeds::problemStatement :> PRJ::problemStatement;

            concern thermalRelief : ThermalRelief;
            concern comfortWithoutAttention : ComfortWithoutAttention;
            concern simpleUseAndControl : SimpleUseAndControl;
            concern undisturbedSharedWorkspace : UndisturbedSharedWorkspace;
            concern privacyOfPeopleNearby : PrivacyOfPeopleNearby;
            concern safeNearbyUse : SafeNearbyUse;
            concern fitsOrdinaryWorkplaces : FitsOrdinaryWorkplaces;
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
    }
}
