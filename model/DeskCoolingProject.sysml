package <DCD> DeskCooling {
    doc
    /* The SYSMOD project of the intelligent desk cooling device.
     *
     * The project is the shared context that links the engineering artifacts.
     * At this stage it contains only the results of activity 1: the project
     * stakeholders and their needs. Further artifacts are added by the
     * later activities of method/01-development-process.md.
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
        part productManager : ProductManager :> projectStakeholders;

        //------------------------- Stakeholder Needs
        concern :>> stakeholderNeeds {
            doc
            /* The needs carry no subject yet. The system of interest is
             * established in activity 2 "System Context and Use Cases". */

            concern thermalRelief : ThermalRelief;
            concern comfortWithoutAttention : ComfortWithoutAttention;
            concern simpleUseAndControl : SimpleUseAndControl;
            concern undisturbedSharedWorkspace : UndisturbedSharedWorkspace;
            concern privacyOfPeopleNearby : PrivacyOfPeopleNearby;
            concern safeNearbyUse : SafeNearbyUse;
            concern fitsOrdinaryWorkplaces : FitsOrdinaryWorkplaces;
        }
    }
}
