import { setPref } from './utils';

// Sets the appropriate number of springboard columns and rows.
(async () => {
    setPref("dock", "springboard-rows", 6);
    setPref("dock", "springboard-columns", 10);
})();