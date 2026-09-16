package <DCD_DECISIONS> DeskCoolingDecisions {
    doc
    /* Engineering decisions and assumptions of the intelligent desk cooling
     * device.
     *
     * A decision records a choice that narrowed the solution space. An
     * assumption records something the development relies on but does not
     * control. Each record annotates the model element it produced or that
     * relies on it, so that neither can be read without the other.
     *
     * Each decision is linked by a dependency to the stakeholder needs it
     * serves, and to any assumption it rests on. The dependency runs from the
     * dependent element to what it rests on, so that following it answers
     * "why is this so?" and following it backwards answers "what breaks if
     * this changes?".
     *
     * Identifiers are assigned once and are never reused. A decision that no
     * longer holds is marked superseded rather than deleted.
     * See method/00-development-process.md, section "Decisions and Assumptions".
     */

    private import ScalarValues::String;
    private import DCD_STAKEHOLDERNEEDS::*;

    //------------------------- Record types

    enum def DecisionStatusKind {
        doc
        /* Lifecycle of a decision record. */
        proposed;
        accepted;
        superseded;
    }

    metadata def Decision {
        doc
        /* A choice between possible solutions, annotating the element the
         * choice produced. */

        attribute id : String {
            doc /* Identifier of the form D-nn. */
        }
        attribute status : DecisionStatusKind default DecisionStatusKind::accepted;
        attribute rationale : String {
            doc /* Why this choice, in terms of the problem statement and the
                   stakeholder needs. */
        }
        attribute alternatives : String {
            doc /* What was rejected, and why. A decision without rejected
                   alternatives is a description, not a decision. */
        }
    }

    metadata def Assumption {
        doc
        /* Something the development relies on but does not control and has not
         * verified, annotating the element that relies on it. */

        attribute id : String {
            doc /* Identifier of the form A-nn. */
        }
        attribute status : DecisionStatusKind default DecisionStatusKind::accepted;
        attribute rationale : String {
            doc /* Why it is reasonable to rely on this. */
        }
        attribute consequence : String {
            doc /* What follows if the assumption turns out to be false. */
        }
    }

    //------------------------- Activity 2: System Idea

    metadata d01 : Decision about DCD_IDEA::DeskCoolingSystem {
        id = "D-01";
        rationale = "The problem is that one person at one desk is too warm, and the office neighbor needs their own working conditions left alone. A device serving a single workplace addresses the desk worker without changing the shared room.";
        alternatives = "Conditioning the whole room, by an air conditioner or by the building's ventilation, was rejected: it changes the conditions of everyone in the room, it cannot be installed by the user, and it is outside the intended market of an ordinary workplace.";
    }

    metadata d02 : Decision about DCD_IDEA::DeskCoolingSystem, DCD_IDEA::DeskCoolingSystemIdeaContext::workplaceEnvironment {
        id = "D-02";
        rationale = "Relief is produced by directing a stream of the surrounding room air at the person. Air movement gives immediate perceptible relief, adds no substance to the workplace, and needs no maintenance by the user.";
        alternatives = "Refrigerating the air was rejected as too large, too power-hungry, and too noisy for a desk. Evaporative cooling was rejected because it requires a water supply and regular refilling by the user, and it adds humidity to a shared room. Each rejected alternative would put a different entity at the boundary in place of the workplace environment as the source of the working fluid.";
    }

    metadata d03 : Decision about DCD_IDEA::DeskCoolingSystemIdeaContext::usbPowerSource {
        id = "D-03";
        rationale = "The system is powered from a USB port of the equipment already on the desk. This keeps the device usable at an ordinary workplace with no preparation: no free mains outlet, no installation, and no charging routine.";
        alternatives = "A mains adapter was rejected because it needs a free outlet and adds a cable to the floor. An internal battery was rejected because it makes the desk worker responsible for charging, which is the kind of attention the comfort needs ask the system to avoid.";
    }

    metadata a01 : Assumption about DCD_IDEA::DeskCoolingSystemIdeaContext::usbPowerSource {
        id = "A-01";
        rationale = "The intended market is workplaces at which a person works with a computer. Such workplaces provide at least one spare USB host port, and it remains powered while the person is working.";
        consequence = "If a spare powered USB port is not available at the intended workplaces, decision D-03 fails and the power source of the system has to be reconsidered. The system boundary changes with it.";
    }

    metadata a02 : Assumption about DCD_IDEA::DeskCoolingSystem, DCD_IDEA::DeskCoolingSystemIdeaContext::workplaceEnvironment {
        id = "A-02";
        rationale = "Moving unconditioned room air over a person relieves the sensation of being too warm at the temperatures that occur at an ordinary workplace.";
        consequence = "If the room air is too warm for air movement alone to give relief, decision D-02 fails, no amount of airflow satisfies the thermal relief need, and a cooling mechanism that lowers the air temperature is required instead.";
    }

    //------------------------- What the decisions serve

    dependency d01MotivatedBy from d01 to ThermalRelief, UndisturbedSharedWorkspace, FitsOrdinaryWorkplaces {
        doc
        /* D-01 serves the desk worker's need for relief while leaving the
           office neighbor's conditions alone, at an ordinary workplace. If any
           of these needs changes, the choice of a single-workplace device is
           reopened. */
    }

    dependency d02MotivatedBy from d02 to ThermalRelief, ComfortWithoutAttention, UndisturbedSharedWorkspace {
        doc
        /* D-02 serves relief that needs no attention from the desk worker and
           adds nothing to a shared room. The rejected alternatives each fail one
           of these needs. */
    }

    dependency d03MotivatedBy from d03 to FitsOrdinaryWorkplaces, ComfortWithoutAttention {
        doc
        /* D-03 serves use at an ordinary workplace without preparation, and
           without a charging routine for the desk worker to maintain. */
    }

    //------------------------- What the decisions rest on

    dependency d02RestsOn from d02 to a02 {
        doc
        /* D-02 is valid only while air movement alone gives relief at workplace
           temperatures. */
    }

    dependency d03RestsOn from d03 to a01 {
        doc
        /* D-03 is valid only while the intended workplaces provide a spare,
           powered USB host port. */
    }
}
