package org.openmrs.distro.bahmni;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.ModuleActivator;

public class Activator implements ModuleActivator {

    protected Log log = LogFactory.getLog(getClass());

    /**
     * @see ModuleActivator#willRefreshContext()
     */
    public void willRefreshContext() {
        log.info("Refreshing Registration App for Bhamni Module");
    }

    /**
     * @see ModuleActivator#contextRefreshed()
     */
    public void contextRefreshed() {
        log.info("Registration App for Bhamni Module refreshed");
    }

    /**
     * @see ModuleActivator#willStart()
     */
    public void willStart() {
        log.info("Starting Registration App for Bhamni Module");
    }

    /**
     * @see ModuleActivator#started()
     */
    public void started() {
        log.info("Registration App for Bhamni Module started");
    }

    /**
     * @see ModuleActivator#willStop()
     */
    public void willStop() {
        log.info("Stopping Registration App for Bhamni Module");
    }

    /**
     * @see ModuleActivator#stopped()
     */
    public void stopped() {
        log.info("Registration App for Bhamni Module stopped");
    }

}
