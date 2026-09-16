package <DCD_CONTEXT> DeskCoolingSystemContext {
    doc
    /* The specification context of the intelligent desk cooling device.
     *
     * Result of activity 3 "System Context and Use Cases". It specializes the
     * system idea context of activity 2, determines what crosses each
     * interface, and owns the system use cases. It is a black box: internal
     * structure is decided in activity 5.
     * See method/03-system-context-and-use-cases.md.
     */

    private import SYSMOD::*;
    private import DCD_STAKEHOLDERNEEDS::*;

    //------------------------- What crosses the boundary

    item def CoolingEffect {
        doc
        /* The relief the system delivers to the desk worker. Described as the
           effect it has, not as the mechanism that carries it. */
    }

    item def ReliefSetting {
        doc
        /* How much relief the desk worker currently wants. */
    }

    item def ServiceIndication {
        doc
        /* What the system makes observable about its own state: that it is
           ready to give relief, and how much it is giving. */
    }

    item def ElectricalPower {
        doc
        /* The electrical power the system draws to operate. */
    }

    item def RoomAir {
        doc
        /* The air of the room, taken from the workplace environment and
           returned to it. */
    }

    item def Emission {
        doc
        /* Everything the system releases into the room besides the relief it
           directs at the desk worker: sound, stray air movement, and waste
           heat. What the office neighbor is exposed to. */
    }

    //------------------------- System of interest

    part def DeskCoolingSystem :> DCD_IDEA::DeskCoolingSystem {
        doc
        /* The specification system as a black box. It redefines the ports of
           the system idea with the items that cross them. */

        port :>> deskWorkerPort {
            out item coolingEffect : CoolingEffect;
            out item serviceIndication : ServiceIndication;
            in item reliefSetting : ReliefSetting;
        }

        port :>> powerPort {
            in item electricalPower : ElectricalPower;
        }

        port :>> environmentPort {
            inout item roomAir : RoomAir;
            out item emission : Emission;
        }

        //--------------- Black-box behavior
        // What the system does, observed from outside. How it does any of it is
        // decided in activity 5.

        action acceptPower {
            doc /* Takes the electrical power offered at the power interface. */
            in item electricalPower : ElectricalPower;
        }

        action indicateService {
            doc /* Makes the system's own state observable to the desk worker:
                   that it is ready, and how much relief it is giving. */
            out item serviceIndication : ServiceIndication;
        }

        action acceptReliefSetting {
            doc /* Takes the amount of relief the desk worker asks for,
                   including none at all. */
            in item reliefSetting : ReliefSetting;
        }

        action deliverRelief {
            doc /* Draws air from the workplace environment and directs it at
                   the desk worker as relief, at the level last asked for. */
            in item roomAir : RoomAir;
            out item coolingEffect : CoolingEffect;
        }

        action sustainRelief {
            doc /* Keeps the relief effective while the desk worker works and
                   changes posture, without any action by them. Whether by a
                   wide airflow, by following them, or otherwise, is not decided
                   here. */
        }
    }

    //------------------------- Context

    #systemContext part def DeskCoolingSystemContext :> DCD_IDEA::DeskCoolingSystemIdeaContext {
        doc
        /* The black-box specification context. The boundary and the actors are
           inherited from the system idea context; this context determines what
           crosses each interface and owns the system use cases. */

        #System part deskCoolingSystem :>> DCD_IDEA::DeskCoolingSystemIdeaContext::deskCoolingSystem : DeskCoolingSystem;

        use case putIntoService : UseCases::PutIntoService :> useCases {
            subject :>> deskCoolingSystem :> DeskCoolingSystemContext::deskCoolingSystem;
            actor :>> deskWorker :> DeskCoolingSystemContext::deskWorker;
            actor :>> usbPowerSource :> DeskCoolingSystemContext::usbPowerSource;
        }

        use case provideRelief : UseCases::ProvideRelief :> useCases {
            subject :>> deskCoolingSystem :> DeskCoolingSystemContext::deskCoolingSystem;
            actor :>> deskWorker :> DeskCoolingSystemContext::deskWorker;
            actor :>> workplaceEnvironment :> DeskCoolingSystemContext::workplaceEnvironment;
            actor :>> usbPowerSource :> DeskCoolingSystemContext::usbPowerSource;
        }

        use case adjustRelief : UseCases::AdjustRelief :> useCases {
            subject :>> deskCoolingSystem :> DeskCoolingSystemContext::deskCoolingSystem;
            actor :>> deskWorker :> DeskCoolingSystemContext::deskWorker;
        }
    }

    //------------------------- Use cases

    package UseCases {
        doc
        /* The system use cases: the interactions the system must support,
           described from outside.
         *
         * Three of the seven stakeholder needs are not addressed by any use
         * case, because no interaction can address them. They are satisfied by
         * properties of the system and become system requirements in
         * activity 4:
         *
         *   UndisturbedSharedWorkspace - met by limiting the Emission the
         *     system releases into the room. The office neighbor is affected
         *     through the workplace environment and is not an actor, so there
         *     is no interaction with them to describe.
         *
         *   PrivacyOfPeopleNearby - met by what the system does not do: retain
         *     or release information about the people around it. A property
         *     has no observable result of value, so it is not a use case.
         *
         *   SafeNearbyUse - met by the system remaining harmless throughout
         *     every use case, rather than by an interaction of its own.
         */

        #systemUseCase use case def PutIntoService {
            doc
            /* The desk worker makes the system ready to use at their
               workplace. */

            subject deskCoolingSystem : DeskCoolingSystem;

            actor deskWorker;
            actor usbPowerSource;

            objective {
                doc
                /* The desk worker makes the system ready to give relief at an
                   ordinary workplace, using only what that workplace already
                   provides, and without changing it. */

                frame concern fitsOrdinaryWorkplaces : FitsOrdinaryWorkplaces;
            }

            attribute ucMotivation :>> ucMotivation = "The desk worker wants relief at a workplace where the system is not yet in service, and is not willing to prepare or modify the workplace, or to have someone install anything, in order to get it.";
            attribute ucTrigger :>> ucTrigger = "The desk worker places the system at the workplace and connects it to a power source the workplace already provides.";
            attribute ucResult :>> ucResult = "The system is ready to give relief, and the workplace is unchanged.";

            constraint precondition :>> precondition {
                doc
                /* The workplace offers space for the system within reach of the
                   desk worker, and a spare power source of the kind the system
                   uses, as recorded in assumption A-01. */
            }

            constraint postcondition :>> postcondition {
                doc
                /* The system is supplied with power and ready to give relief.
                   Nothing at the workplace was installed, modified, or
                   displaced to achieve this. */
            }

            // The desk worker connecting the system is the trigger; it appears
            // in the flow as the power the system accepts.
            action acceptPower :> deskCoolingSystem.acceptPower;
            action indicateService :> deskCoolingSystem.indicateService;

            first start then acceptPower;
            first acceptPower then indicateService;
            first indicateService then done;
        }

        #systemUseCase use case def ProvideRelief {
            doc
            /* The system relieves the desk worker and keeps doing so while they
               work. */

            subject deskCoolingSystem : DeskCoolingSystem;

            actor deskWorker;
            actor workplaceEnvironment;
            actor usbPowerSource;

            objective {
                doc
                /* The desk worker stops feeling too warm at their workplace,
                   and stays that way while they work, without having to attend
                   to the system. */

                frame concern thermalRelief : ThermalRelief;
                frame concern comfortWithoutAttention : ComfortWithoutAttention;
            }

            attribute ucMotivation :>> ucMotivation = "The desk worker feels too warm at their workplace, and wants that to stop without giving up attention that belongs to their work.";
            attribute ucTrigger :>> ucTrigger = "The desk worker starts the system.";
            attribute ucResult :>> ucResult = "The desk worker experiences relief, and it remains effective as they move and change posture, until they stop the system.";

            constraint precondition :>> precondition {
                doc
                /* The system is in service at the workplace and the desk worker
                   is present at it. */
            }

            constraint postcondition :>> postcondition {
                doc
                /* The desk worker has experienced relief for as long as the
                   system was running, without having acted to maintain it. */
            }

            action acceptReliefSetting :> deskCoolingSystem.acceptReliefSetting;
            action deliverRelief :> deskCoolingSystem.deliverRelief;
            action sustainRelief :> deskCoolingSystem.sustainRelief;

            first start then acceptReliefSetting;
            first acceptReliefSetting then deliverRelief;
            first deliverRelief then sustainRelief;
            first sustainRelief then done;
        }

        #systemUseCase use case def AdjustRelief {
            doc
            /* The desk worker changes how much relief the system gives. */

            subject deskCoolingSystem : DeskCoolingSystem;

            actor deskWorker;

            objective {
                doc
                /* The desk worker brings the amount of relief to what they
                   currently want, including none at all, without leaving their
                   work to do it. */

                frame concern simpleUseAndControl : SimpleUseAndControl;
            }

            attribute ucMotivation :>> ucMotivation = "What the desk worker wants changes during the day, with the room, their clothing, and what they are doing. Relief that cannot be changed is either too little or too much most of the time.";
            attribute ucTrigger :>> ucTrigger = "The desk worker asks the system for a different amount of relief.";
            attribute ucResult :>> ucResult = "The relief the system gives corresponds to what the desk worker asked for.";

            constraint precondition :>> precondition {
                doc
                /* The system is in service at the workplace. */
            }

            constraint postcondition :>> postcondition {
                doc
                /* The system gives relief at the level the desk worker asked
                   for, and the desk worker did not have to interrupt their work
                   to achieve it. Stopping the system is the case where that
                   level is none. */
            }

            action acceptReliefSetting :> deskCoolingSystem.acceptReliefSetting;
            action deliverRelief :> deskCoolingSystem.deliverRelief;
            action indicateService :> deskCoolingSystem.indicateService;

            first start then acceptReliefSetting;
            first acceptReliefSetting then deliverRelief;
            first deliverRelief then indicateService;
            first indicateService then done;
        }
    }
}
