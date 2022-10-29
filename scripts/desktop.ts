import {setPref} from './utils';

(() => {
    // These preferneces are set to the `com.apple.finder` domain, but are 
    // related to the functionality of the desktop.
    setPref("finder", "ShowHardDrivesOnDesktop", true);
    setPref("finder", "ShowExternalHardDrivesOnDesktop", true);
    setPref("finder", "ShowRemovableMediaOnDesktop", true);
    setPref("finder", "ShowMountedServersOnDesktop", true);
})();