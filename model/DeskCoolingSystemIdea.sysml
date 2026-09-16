package <DCD_IDEA> DeskCoolingSystemIdea {
    doc
    /* The system idea of the intelligent desk cooling device.
     *
     * Result of activity 2 "System Idea". It commits to the kind of solution
     * that will be developed and introduces the actors that this commitment
     * puts at the system boundary. It does not describe internal structure.
     * The decisions and assumptions behind the commitment are recorded in
     * model/DeskCoolingDecisions.sysml.
     * See method/03-system-idea.md.
     */

    private import SYSMOD::*;

    #systemContext part def DeskCoolingSystemIdeaContext {
        doc
        /* The black-box system idea context: the system of interest as committed
         * by the system idea, together with the actors that the commitment
         * itself forces. Activity 3 specializes this context into the
         * specification context and adds the remaining actors and the use
         * cases. */

        #System part deskCoolingSystem : DeskCoolingSystem :>> soi {
            doc
            /* The system idea as a black box. */
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

        interface usbPowerSupply :> asis connect usbPowerSource.powerPort to deskCoolingSystem.powerPort {
            doc
            /* Supply of electrical power from the USB host port to the system.
             * The power available over this interface bounds the cooling effect
             * the system can produce. */
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

        port powerPort {
            doc
            /* Port through which the system receives electrical power. */
        }
    }
}
