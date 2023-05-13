const fs = require('fs/promises');

type TextReplacement = [string, string];

interface ReplacementGroup {
    title: string;
    replacements: TextReplacement[];
}

/**
 * Generates the 10 subscript replacements that are required (from 0–9). Note that there is no superscript
 * replacement function, because there is no complete character code ordering in the Unicode sequence
 * that easily contains each superscript integer (integers 2 & 3 are out of sequence).
 * 
 * @returns {TextReplacement[]} - An array of string, string tuples representing all subscript replacements.
 */
const generateSubscriptReplacements = (): TextReplacement[] => {
    return Array(10).fill(null)
        .map((e, i) => [`_${i}`, String.fromCharCode(parseInt((2080 + i).toString(), 16))])
};

/** 
 * Reads out the custom replacements from the `textreplacements.json` file.
 * 
 * @returns {Promise<TextReplacement[]>} - A `Promise` resolving to an array of `TextReplacement`'s.
 */
const readCustomReplacements = async (): Promise<TextReplacement[]> => {
    return JSON.parse(await fs.readFile('./textreplacements.json'))
        .flatMap((e: ReplacementGroup) => e.replacements);
}

/**
 * Generates a text replacement `dict` as a string, that will be included in the generated plist file. 
 * Any angle brackets in shortcut are replaced with the equivalent HTML entities.
 * 
 * @param shortcut - The string of characters that should act as a text replacement.
 * @param phrase - The replaced text.
 * 
 * @returns {string} - The XML structure of the replacement.
 */
const createReplacement = (shortcut: string, phrase: string): string => {
    const htmlEntities: Record<string, string> = {
        "<": "&lt;",
        ">": "&gt;",
    };

    for (const entity in htmlEntities) {
        shortcut = shortcut.replaceAll(entity, htmlEntities[entity]);
    }

    return `    <dict>
        <key>phrase</key>
        <string>${phrase}</string>
        <key>shortcut</key>
        <string>${shortcut}</string>
    </dict>`; 
}

/**
 * Generates and writes the 'Text Substitutions.plist' file.
 * 
 * @param {string} plistBody - The plist contents containing the replacements.
 */
const writePlist = async(plistBody: string): Promise<void> => {
    await fs.writeFile('Text Substitutions.plist', 
`<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
${plistBody}
</array>
</plist>`
    );
}

(async () => {
    const replacements = [
        ...generateSubscriptReplacements(),
        ...await readCustomReplacements()
    ];

    console.log(`Generating 'Text Substitutions.plist' for ${replacements.length} replacements…`);

    return await writePlist(
        replacements.map(([p, s]) => createReplacement(p, s)).join('\n')
    );
})();