'use strict'

// modified from accounting.js
function parseNum (value, decimalSep) {
    if (value == null) return NaN
    decimalSep = decimalSep || '.'

    // Return the value as-is if it's already a number:
    if (typeof value === 'number') return value

    // build regex to strip out everything except digits, decimal point and minus sign:
    var regex = new RegExp('[^0-9-' + decimalSep + ']', ['g'])
    var unformatted = value.toString() // explicitly convert to string
    unformatted = unformatted
    // .replace(/\((.*)\)/, '-$1') // replace bracketed values with negatives
        .replace(regex, '')         // strip out any cruft
        .replace(decimalSep, '.')   // make sure decimal point is standard

    unformatted = parseFloat(unformatted)

    return unformatted
}

module.exports.parseNum = parseNum;




/* global Intl */

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat
const defaultOptions = {
    nanZero: true,
    locale: 'en-US',
    localeMatcher: 'best fit',
    useGrouping: true, // grouping separator determined by locale
    maximumFractionDigits: 15
    // OTHER
    // minimumIntegerDigits
    // minimumFractionDigits
    // maximumFractionDigits
    // minimumSignificantDigits
    // maximumSignificantDigits
}

const formatNum = (number, opts) => {
    console.log("[format-number]")
    opts = renameKeyShortcuts(Object.assign({}, defaultOptions, opts))
    number = parseNum(number)

    if (isNaN(number)) {
        console.log("isNaN", number);
        if (opts.nanZero === false) return number;
        else number = 0
    }

    const nf = new Intl.NumberFormat([opts.locale], Object.assign({}, opts, { style: 'decimal' }))
    return nf.format(number)
}

const renameKeyShortcuts = (opts) => {
    Object.keys(opts).forEach((key) => {
        expandMin(opts, key)
        expandMax(opts, key)
    })

    Object.keys(opts).forEach((key) => addDigits(opts, key))

    return opts
}

const expandMin = (opts, key) => expand(opts, key, 'min', 'minimum')
const expandMax = (opts, key) => expand(opts, key, 'max', 'maximum')

const expand = (opts, key, shorthand, full) => {
    if (!key.includes(full) && key.startsWith(shorthand)) {
        replaceKey(opts, key, key.replace(shorthand, full))
    }
}

const addDigits = (opts, key) => {
    if (
        (key.startsWith('minimum') || key.startsWith('maximum')) &&
        !key.endsWith('Digits')
    ) {
        replaceKey(opts, key, key + 'Digits')
    }
}

const replaceKey = (obj, oldKey, newKey) => {
    obj[newKey] = obj[oldKey]
    delete obj[oldKey]
}

module.exports.formatNum = formatNum;
