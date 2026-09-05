package <DCD_STAKEHOLDERS> DeskCoolingStakeholders {
    doc
    /* Stakeholders of the intelligent desk cooling device.
     *
     * Result of activity 1 "Stakeholders and Needs".
     * See method/02-stakeholders-and-needs.md.
     */

    private import SYSMOD::*;

    #extendedStakeholder part def DeskWorker {
        doc
        /* The person working at the desk that the system serves. Experiences the
         * cooling effect directly and is the reason the system exists. Source of
         * the comfort, usability, and privacy needs. */

        attribute :>> risk = LevelKind::critical;
        attribute :>> effort = LevelKind::low;
        attribute :>> categories = StakeholderCategoryKind::user;
    }

    #extendedStakeholder part def OfficeNeighbor {
        doc
        /* A person sharing the workspace who is affected by the system without
         * interacting with it. Receives no benefit from it, so their interests
         * oppose those of the desk worker. Source of the needs that limit the
         * effect of the system on its surroundings. */

        attribute :>> risk = LevelKind::medium;
        attribute :>> effort = LevelKind::medium;
        attribute :>> categories = StakeholderCategoryKind::other;
    }

    #extendedStakeholder part def ProductManager {
        doc
        /* The role that decides what the system must do and resolves conflicts
         * between the desk worker and the office neighbor. Source of the needs
         * concerning the intended market. */

        attribute :>> risk = LevelKind::high;
        attribute :>> effort = LevelKind::low;
        attribute :>> categories = StakeholderCategoryKind::requirementOwner;
    }
}

package <DCD_STAKEHOLDERNEEDS> DeskCoolingStakeholderNeeds {
    doc
    /* Stakeholder needs of the intelligent desk cooling device.
     *
     * Result of activity 1 "Stakeholders and Needs".
     * Needs describe desired outcomes, not solutions. They are not yet
     * verifiable and carry no subject at this stage.
     * See method/02-stakeholders-and-needs.md.
     */

    private import SYSMOD::*;
    private import DCD_STAKEHOLDERS::*;

    #extendedConcern concern def ThermalRelief {
        doc
        /* The desk worker needs relief from feeling too warm at their workplace
         * so that they can keep working comfortably. */

        subject systemOfInterest;

        stakeholder deskWorker : DeskWorker;

        attribute :>> priority = LevelKind::critical;
    }

    #extendedConcern concern def ComfortWithoutAttention {
        doc
        /* The desk worker needs the relief to remain effective as they move and
         * change posture at their desk so that they do not have to interrupt
         * their work to maintain it. */

        subject systemOfInterest;

        stakeholder deskWorker : DeskWorker;

        attribute :>> priority = LevelKind::high;
    }

    #extendedConcern concern def SimpleUseAndControl {
        doc
        /* The desk worker needs the system to be easy to start and adjust so
         * that they can obtain their preferred level of relief without
         * distracting from their work. */

        subject systemOfInterest;

        stakeholder deskWorker : DeskWorker;

        attribute :>> priority = LevelKind::medium;
    }

    #extendedConcern concern def UndisturbedSharedWorkspace {
        doc
        /* The office neighbor needs the system not to disturb their working
         * conditions so that another person's comfort does not reduce their
         * own. */

        subject systemOfInterest;

        stakeholder officeNeighbor : OfficeNeighbor;

        attribute :>> priority = LevelKind::high;
    }

    #extendedConcern concern def PrivacyOfPeopleNearby {
        doc
        /* People near the system need it not to expose information about them
         * or their workplace so that they can work without feeling observed. */

        subject systemOfInterest;

        stakeholder deskWorker : DeskWorker;
        stakeholder officeNeighbor : OfficeNeighbor;

        attribute :>> priority = LevelKind::high;
    }

    #extendedConcern concern def SafeNearbyUse {
        doc
        /* People near the system need it to operate without causing harm during
         * normal prolonged use. */

        subject systemOfInterest;

        stakeholder deskWorker : DeskWorker;
        stakeholder officeNeighbor : OfficeNeighbor;

        attribute :>> priority = LevelKind::critical;
    }

    #extendedConcern concern def FitsOrdinaryWorkplaces {
        doc
        /* The product manager needs the system to be usable at ordinary desks
         * and workplaces without preparation or modification so that it serves
         * the intended market. */

        subject systemOfInterest;

        stakeholder productManager : ProductManager;

        attribute :>> priority = LevelKind::high;
    }
}
