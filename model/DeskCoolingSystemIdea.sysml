package <DCD_IDEA> DeskCoolingSystemIdea {
    doc
    /* The system idea of the intelligent desk cooling device.
     *
     * Result of activity 2 "System Idea". It commits to the kind of solution
     * that will be developed and establishes the system boundary that follows
     * from the commitment. It does not describe internal structure.
     * The decisions and assumptions behind the commitment are recorded in
     * model/DeskCoolingDecisions.sysml.
     * See method/02-system-idea.md.
     */

    private import SYSMOD::*;

    #systemContext part def DeskCoolingSystemIdeaContext {
        doc
        /* The black-box system idea context: the system of interest as committed
         * by the system idea, together with every external entity that
         * interacts with it. This is the first context of the chain, because
         * this project develops no brownfield context, so it is complete
         * rather than a delta. Activity 3 specializes it into the
         * specification context, which details what crosses each interface and
         * adds the use cases. */

        #System part deskCoolingSystem : DeskCoolingSystem :>> soi {
            doc
            /* The system idea as a black box. */
        }

        #User part deskWorker :> actors {
            doc
            /* The person working at the desk. They are the reason the system
               exists: they receive its cooling effect, and they start and
               adjust it. Corresponds to the DeskWorker stakeholder of
               activity 1, but is a distinct element: a stakeholder holds an
               interest, an actor occupies a position at the boundary. */

            port coolingPort;
        }

        #EnvironmentalEffect part workplaceEnvironment :> actors {
            doc
            /* The air and the conditions of the room the workplace is in. It
               is the source of the air the system moves and the receiver of
               everything the system emits: noise, draft, and waste heat.

               The office neighbor is affected through this environment and not
               by any exchange with the system, so the office neighbor remains a
               stakeholder and is not modeled as an actor. Their need is met by
               properties of the system limiting what it emits here, not by an
               interaction with them. */

            port roomAirPort;
        }

        #ExternalSystem part usbPowerSource :> actors {
            doc
            /* The USB host port of the equipment already present at the
             * workplace, typically the desk worker's computer. It supplies the
             * electrical power the system runs on. It is an actor only because
             * of decision D-03; a mains-powered or battery-powered device would
             * have a different entity, or none, at this position. */

            port powerPort;
        }

        interface deskWorkerInteraction :> asis connect deskWorker.coolingPort to deskCoolingSystem.deskWorkerPort {
            doc
            /* The cooling effect the system directs at the desk worker, and the
             * desk worker's commands to start and adjust it. What exactly
             * crosses this interface is detailed in activity 3. */
        }

        interface usbPowerSupply :> asis connect usbPowerSource.powerPort to deskCoolingSystem.powerPort {
            doc
            /* Supply of electrical power from the USB host port to the system.
             * The power available over this interface bounds the cooling effect
             * the system can produce. */
        }

        interface environmentExchange :> asis connect workplaceEnvironment.roomAirPort to deskCoolingSystem.environmentPort {
            doc
            /* The room air the system takes in and returns, and everything the
             * system emits into the room around it. */
        }
    }

    part def DeskCoolingSystem {
        doc
        /* System idea: a tabletop fan for a single workplace.
         *
         * The device stands on the desk next to the person it serves and cools
         * them by directing a stream of the surrounding room air at them, rather
         * than by lowering the temperature of the room. It draws its power from
         * a USB port of the equipment already on the desk, so that it needs no
         * installation, no mains outlet of its own, and no servicing.
         *
         * This is a commitment to a kind of solution, not a design. How the
         * airflow is produced, directed, and controlled is decided in
         * activity 5. */

        port deskWorkerPort {
            doc
            /* Port through which the system acts on the desk worker and
             * receives their commands. */
        }

        port powerPort {
            doc
            /* Port through which the system receives electrical power. */
        }

        port environmentPort {
            doc
            /* Port through which the system exchanges air with the room and
             * emits into it. */
        }
    }
}
