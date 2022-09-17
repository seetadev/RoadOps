(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined' ? factory(exports, require('react')) :
    typeof define === 'function' && define.amd ? define(['exports', 'react'], factory) :
    (global = typeof globalThis !== 'undefined' ? globalThis : global || self, factory(global.ReactCurrencyInputField = {}, global.React));
}(this, (function (exports, React) { 'use strict';

    function _interopDefaultLegacy (e) { return e && typeof e === 'object' && 'default' in e ? e : { 'default': e }; }

    var React__default = /*#__PURE__*/_interopDefaultLegacy(React);

    /*! *****************************************************************************
    Copyright (c) Microsoft Corporation.

    Permission to use, copy, modify, and/or distribute this software for any
    purpose with or without fee is hereby granted.

    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
    REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
    AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
    INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
    LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
    OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
    PERFORMANCE OF THIS SOFTWARE.
    ***************************************************************************** */

    var __assign = function() {
        __assign = Object.assign || function __assign(t) {
            for (var s, i = 1, n = arguments.length; i < n; i++) {
                s = arguments[i];
                for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
            }
            return t;
        };
        return __assign.apply(this, arguments);
    };

    function __rest(s, e) {
        var t = {};
        for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
            t[p] = s[p];
        if (s != null && typeof Object.getOwnPropertySymbols === "function")
            for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
                if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                    t[p[i]] = s[p[i]];
            }
        return t;
    }

    function __spreadArray(to, from, pack) {
        if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
            if (ar || !(i in from)) {
                if (!ar) ar = Array.prototype.slice.call(from, 0, i);
                ar[i] = from[i];
            }
        }
        return to.concat(ar || from);
    }

    /**
     * Escape regex char
     *
     * See: https://stackoverflow.com/questions/17885855/use-dynamic-variable-string-as-regex-pattern-in-javascript
     */
    var escapeRegExp = function (stringToGoIntoTheRegex) {
        return stringToGoIntoTheRegex.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
    };

    var abbrMap = { k: 1000, m: 1000000, b: 1000000000 };
    /**
     * Parse a value with abbreviation e.g 1k = 1000
     */
    var parseAbbrValue = function (value, decimalSeparator) {
        if (decimalSeparator === void 0) { decimalSeparator = '.'; }
        var reg = new RegExp("(\\d+(" + escapeRegExp(decimalSeparator) + "\\d*)?)([kmb])$", 'i');
        var match = value.match(reg);
        if (match) {
            var digits = match[1], abbr = match[3];
            var multiplier = abbrMap[abbr.toLowerCase()];
            return Number(digits.replace(decimalSeparator, '.')) * multiplier;
        }
        return undefined;
    };

    /**
     * Remove group separator from value eg. 1,000 > 1000
     */
    var removeSeparators = function (value, separator) {
        if (separator === void 0) { separator = ','; }
        var reg = new RegExp(escapeRegExp(separator), 'g');
        return value.replace(reg, '');
    };

    /**
     * Remove invalid characters
     */
    var removeInvalidChars = function (value, validChars) {
        var chars = escapeRegExp(validChars.join(''));
        var reg = new RegExp("[^\\d" + chars + "]", 'gi');
        return value.replace(reg, '');
    };

    /**
     * Remove prefix, separators and extra decimals from value
     */
    var cleanValue = function (_a) {
        var value = _a.value, _b = _a.groupSeparator, groupSeparator = _b === void 0 ? ',' : _b, _c = _a.decimalSeparator, decimalSeparator = _c === void 0 ? '.' : _c, _d = _a.allowDecimals, allowDecimals = _d === void 0 ? true : _d, _e = _a.decimalsLimit, decimalsLimit = _e === void 0 ? 2 : _e, _f = _a.allowNegativeValue, allowNegativeValue = _f === void 0 ? true : _f, _g = _a.disableAbbreviations, disableAbbreviations = _g === void 0 ? false : _g, _h = _a.prefix, prefix = _h === void 0 ? '' : _h, _j = _a.transformRawValue, transformRawValue = _j === void 0 ? function (rawValue) { return rawValue; } : _j;
        var transformedValue = transformRawValue(value);
        if (transformedValue === '-') {
            return transformedValue;
        }
        var abbreviations = disableAbbreviations ? [] : ['k', 'm', 'b'];
        var reg = new RegExp("((^|\\D)-\\d)|(-" + escapeRegExp(prefix) + ")");
        var isNegative = reg.test(transformedValue);
        // Is there a digit before the prefix? eg. 1$
        var _k = RegExp("(\\d+)-?" + escapeRegExp(prefix)).exec(value) || [], prefixWithValue = _k[0], preValue = _k[1];
        var withoutPrefix = prefix
            ? prefixWithValue
                ? transformedValue.replace(prefixWithValue, '').concat(preValue)
                : transformedValue.replace(prefix, '')
            : transformedValue;
        var withoutSeparators = removeSeparators(withoutPrefix, groupSeparator);
        var withoutInvalidChars = removeInvalidChars(withoutSeparators, __spreadArray([
            groupSeparator,
            decimalSeparator
        ], abbreviations));
        var valueOnly = withoutInvalidChars;
        if (!disableAbbreviations) {
            // disallow letter without number
            if (abbreviations.some(function (letter) { return letter === withoutInvalidChars.toLowerCase(); })) {
                return '';
            }
            var parsed = parseAbbrValue(withoutInvalidChars, decimalSeparator);
            if (parsed) {
                valueOnly = String(parsed);
            }
        }
        var includeNegative = isNegative && allowNegativeValue ? '-' : '';
        if (decimalSeparator && valueOnly.includes(decimalSeparator)) {
            var _l = withoutInvalidChars.split(decimalSeparator), int = _l[0], decimals = _l[1];
            var trimmedDecimals = decimalsLimit && decimals ? decimals.slice(0, decimalsLimit) : decimals;
            var includeDecimals = allowDecimals ? "" + decimalSeparator + trimmedDecimals : '';
            return "" + includeNegative + int + includeDecimals;
        }
        return "" + includeNegative + valueOnly;
    };

    var fixedDecimalValue = function (value, decimalSeparator, fixedDecimalLength) {
        if (fixedDecimalLength && value.length > 1) {
            if (value.includes(decimalSeparator)) {
                var _a = value.split(decimalSeparator), int = _a[0], decimals = _a[1];
                if (decimals.length > fixedDecimalLength) {
                    return "" + int + decimalSeparator + decimals.slice(0, fixedDecimalLength);
                }
            }
            var reg = value.length > fixedDecimalLength
                ? new RegExp("(\\d+)(\\d{" + fixedDecimalLength + "})")
                : new RegExp("(\\d)(\\d+)");
            var match = value.match(reg);
            if (match) {
                var int = match[1], decimals = match[2];
                return "" + int + decimalSeparator + decimals;
            }
        }
        return value;
    };

    var getSuffix = function (value, _a) {
        var _b = _a.groupSeparator, groupSeparator = _b === void 0 ? ',' : _b, _c = _a.decimalSeparator, decimalSeparator = _c === void 0 ? '.' : _c;
        var suffixReg = new RegExp("\\d([^" + escapeRegExp(groupSeparator) + escapeRegExp(decimalSeparator) + "0-9]+)");
        var suffixMatch = value.match(suffixReg);
        return suffixMatch ? suffixMatch[1] : undefined;
    };

    /**
     * Format value with decimal separator, group separator and prefix
     */
    var formatValue = function (options) {
        var _value = options.value, decimalSeparator = options.decimalSeparator, intlConfig = options.intlConfig, decimalScale = options.decimalScale, _a = options.prefix, prefix = _a === void 0 ? '' : _a, _b = options.suffix, suffix = _b === void 0 ? '' : _b;
        if (_value === '' || _value === undefined) {
            return '';
        }
        if (_value === '-') {
            return '-';
        }
        var isNegative = new RegExp("^\\d?-" + (prefix ? escapeRegExp(prefix) + "?" : '') + "\\d").test(_value);
        var value = decimalSeparator !== '.'
            ? replaceDecimalSeparator(_value, decimalSeparator, isNegative)
            : _value;
        var numberFormatter = intlConfig
            ? new Intl.NumberFormat(intlConfig.locale, intlConfig.currency
                ? {
                    style: 'currency',
                    currency: intlConfig.currency,
                    minimumFractionDigits: decimalScale || 0,
                    maximumFractionDigits: 20,
                }
                : undefined)
            : new Intl.NumberFormat(undefined, {
                minimumFractionDigits: decimalScale || 0,
                maximumFractionDigits: 20,
            });
        var parts = numberFormatter.formatToParts(Number(value));
        var formatted = replaceParts(parts, options);
        // Does intl formatting add a suffix?
        var intlSuffix = getSuffix(formatted, __assign({}, options));
        // Include decimal separator if user input ends with decimal separator
        var includeDecimalSeparator = _value.slice(-1) === decimalSeparator ? decimalSeparator : '';
        var _c = value.match(RegExp('\\d+\\.(\\d+)')) || [], decimals = _c[1];
        // Keep original decimal padding if no decimalScale
        if (decimalScale === undefined && decimals && decimalSeparator) {
            if (formatted.includes(decimalSeparator)) {
                formatted = formatted.replace(RegExp("(\\d+)(" + escapeRegExp(decimalSeparator) + ")(\\d+)", 'g'), "$1$2" + decimals);
            }
            else {
                if (intlSuffix && !suffix) {
                    formatted = formatted.replace(intlSuffix, "" + decimalSeparator + decimals + intlSuffix);
                }
                else {
                    formatted = "" + formatted + decimalSeparator + decimals;
                }
            }
        }
        if (suffix && includeDecimalSeparator) {
            return "" + formatted + includeDecimalSeparator + suffix;
        }
        if (intlSuffix && includeDecimalSeparator) {
            return formatted.replace(intlSuffix, "" + includeDecimalSeparator + intlSuffix);
        }
        if (intlSuffix && suffix) {
            return formatted.replace(intlSuffix, "" + includeDecimalSeparator + suffix);
        }
        return [formatted, includeDecimalSeparator, suffix].join('');
    };
    /**
     * Before converting to Number, decimal separator has to be .
     */
    var replaceDecimalSeparator = function (value, decimalSeparator, isNegative) {
        var newValue = value;
        if (decimalSeparator && decimalSeparator !== '.') {
            newValue = newValue.replace(RegExp(escapeRegExp(decimalSeparator), 'g'), '.');
            if (isNegative && decimalSeparator === '-') {
                newValue = "-" + newValue.slice(1);
            }
        }
        return newValue;
    };
    var replaceParts = function (parts, _a) {
        var prefix = _a.prefix, groupSeparator = _a.groupSeparator, decimalSeparator = _a.decimalSeparator, decimalScale = _a.decimalScale, _b = _a.disableGroupSeparators, disableGroupSeparators = _b === void 0 ? false : _b;
        return parts
            .reduce(function (prev, _a, i) {
            var type = _a.type, value = _a.value;
            if (i === 0 && prefix) {
                if (type === 'minusSign') {
                    return [value, prefix];
                }
                if (type === 'currency') {
                    return __spreadArray(__spreadArray([], prev), [prefix]);
                }
                return [prefix, value];
            }
            if (type === 'currency') {
                return prefix ? prev : __spreadArray(__spreadArray([], prev), [value]);
            }
            if (type === 'group') {
                return !disableGroupSeparators
                    ? __spreadArray(__spreadArray([], prev), [groupSeparator !== undefined ? groupSeparator : value]) : prev;
            }
            if (type === 'decimal') {
                if (decimalScale !== undefined && decimalScale === 0) {
                    return prev;
                }
                return __spreadArray(__spreadArray([], prev), [decimalSeparator !== undefined ? decimalSeparator : value]);
            }
            if (type === 'fraction') {
                return __spreadArray(__spreadArray([], prev), [decimalScale !== undefined ? value.slice(0, decimalScale) : value]);
            }
            return __spreadArray(__spreadArray([], prev), [value]);
        }, [''])
            .join('');
    };

    var defaultConfig = {
        currencySymbol: '',
        groupSeparator: '',
        decimalSeparator: '',
        prefix: '',
        suffix: '',
    };
    /**
     * Get locale config from input or default
     */
    var getLocaleConfig = function (intlConfig) {
        var _a = intlConfig || {}, locale = _a.locale, currency = _a.currency;
        var numberFormatter = locale
            ? new Intl.NumberFormat(locale, currency ? { currency: currency, style: 'currency' } : undefined)
            : new Intl.NumberFormat();
        return numberFormatter.formatToParts(1000.1).reduce(function (prev, curr, i) {
            if (curr.type === 'currency') {
                if (i === 0) {
                    return __assign(__assign({}, prev), { currencySymbol: curr.value, prefix: curr.value });
                }
                else {
                    return __assign(__assign({}, prev), { currencySymbol: curr.value, suffix: curr.value });
                }
            }
            if (curr.type === 'group') {
                return __assign(__assign({}, prev), { groupSeparator: curr.value });
            }
            if (curr.type === 'decimal') {
                return __assign(__assign({}, prev), { decimalSeparator: curr.value });
            }
            return prev;
        }, defaultConfig);
    };

    var isNumber = function (input) { return RegExp(/\d/, 'gi').test(input); };

    var padTrimValue = function (value, decimalSeparator, decimalScale) {
        if (decimalSeparator === void 0) { decimalSeparator = '.'; }
        if (decimalScale === undefined || value === '' || value === undefined) {
            return value;
        }
        if (!value.match(/\d/g)) {
            return '';
        }
        var _a = value.split(decimalSeparator), int = _a[0], decimals = _a[1];
        if (decimalScale === 0) {
            return int;
        }
        var newValue = decimals || '';
        if (newValue.length < decimalScale) {
            while (newValue.length < decimalScale) {
                newValue += '0';
            }
        }
        else {
            newValue = newValue.slice(0, decimalScale);
        }
        return "" + int + decimalSeparator + newValue;
    };

    var CurrencyInput = React.forwardRef(function (_a, ref) {
        var _b = _a.allowDecimals, allowDecimals = _b === void 0 ? true : _b, _c = _a.allowNegativeValue, allowNegativeValue = _c === void 0 ? true : _c, id = _a.id, name = _a.name, className = _a.className, customInput = _a.customInput, decimalsLimit = _a.decimalsLimit, defaultValue = _a.defaultValue, _d = _a.disabled, disabled = _d === void 0 ? false : _d, userMaxLength = _a.maxLength, userValue = _a.value, onValueChange = _a.onValueChange, fixedDecimalLength = _a.fixedDecimalLength, placeholder = _a.placeholder, decimalScale = _a.decimalScale, prefix = _a.prefix, suffix = _a.suffix, intlConfig = _a.intlConfig, step = _a.step, min = _a.min, max = _a.max, _e = _a.disableGroupSeparators, disableGroupSeparators = _e === void 0 ? false : _e, _f = _a.disableAbbreviations, disableAbbreviations = _f === void 0 ? false : _f, _decimalSeparator = _a.decimalSeparator, _groupSeparator = _a.groupSeparator, onChange = _a.onChange, onFocus = _a.onFocus, onBlur = _a.onBlur, onKeyDown = _a.onKeyDown, onKeyUp = _a.onKeyUp, transformRawValue = _a.transformRawValue, props = __rest(_a, ["allowDecimals", "allowNegativeValue", "id", "name", "className", "customInput", "decimalsLimit", "defaultValue", "disabled", "maxLength", "value", "onValueChange", "fixedDecimalLength", "placeholder", "decimalScale", "prefix", "suffix", "intlConfig", "step", "min", "max", "disableGroupSeparators", "disableAbbreviations", "decimalSeparator", "groupSeparator", "onChange", "onFocus", "onBlur", "onKeyDown", "onKeyUp", "transformRawValue"]);
        
        if (_decimalSeparator && isNumber(_decimalSeparator)) {
            throw new Error('decimalSeparator cannot be a number');
        }
        if (_groupSeparator && isNumber(_groupSeparator)) {
            throw new Error('groupSeparator cannot be a number');
        }
        var localeConfig = React.useMemo(function () { return getLocaleConfig(intlConfig); }, [intlConfig]);
        var decimalSeparator = _decimalSeparator || localeConfig.decimalSeparator || '';
        var groupSeparator = _groupSeparator || localeConfig.groupSeparator || '';
        if (decimalSeparator &&
            groupSeparator &&
            decimalSeparator === groupSeparator &&
            disableGroupSeparators === false) {
            throw new Error('decimalSeparator cannot be the same as groupSeparator');
        }
        var formatValueOptions = {
            decimalSeparator: decimalSeparator,
            groupSeparator: groupSeparator,
            disableGroupSeparators: disableGroupSeparators,
            intlConfig: intlConfig,
            prefix: prefix || localeConfig.prefix,
            suffix: suffix,
        };
        var cleanValueOptions = {
            decimalSeparator: decimalSeparator,
            groupSeparator: groupSeparator,
            allowDecimals: allowDecimals,
            decimalsLimit: decimalsLimit || fixedDecimalLength || 2,
            allowNegativeValue: allowNegativeValue,
            disableAbbreviations: disableAbbreviations,
            prefix: prefix || localeConfig.prefix,
            transformRawValue: transformRawValue,
        };
        var formattedStateValue = defaultValue !== undefined && defaultValue !== null
            ? formatValue(__assign(__assign({}, formatValueOptions), { decimalScale: decimalScale, value: String(defaultValue) }))
            : userValue !== undefined && userValue !== null
                ? formatValue(__assign(__assign({}, formatValueOptions), { decimalScale: decimalScale, value: String(userValue) }))
                : '';
        var _g = React.useState(formattedStateValue), stateValue = _g[0], setStateValue = _g[1];
        var _h = React.useState(false), dirty = _h[0], setDirty = _h[1];
        var _j = React.useState(0), cursor = _j[0], setCursor = _j[1];
        var inputRef = ref || React.useRef(null);
        /**
         * Process change in value
         */
        var processChange = function (value, selectionStart) {
            setDirty(true);
            var stringValue = cleanValue(__assign({ value: value }, cleanValueOptions));
            if (userMaxLength && stringValue.replace(/-/g, '').length > userMaxLength) {
                return;
            }
            if (stringValue === '' || stringValue === '-' || stringValue === decimalSeparator) {
                onValueChange && onValueChange(undefined, name, { float: null, formatted: '', value: '' });
                setStateValue(stringValue);
                return;
            }
            var numberValue = parseFloat(stringValue.replace(decimalSeparator, '.'));
            var formattedValue = formatValue(__assign({ value: stringValue }, formatValueOptions));
            /* istanbul ignore next */
            if (selectionStart !== undefined && selectionStart !== null) {
                // Prevent cursor jumping
                var newCursor = selectionStart + (formattedValue.length - value.length) || 1;
                setCursor(newCursor);
            }
            setStateValue(formattedValue);
            if (onValueChange) {
                var values = {
                    float: numberValue,
                    formatted: formattedValue,
                    value: stringValue,
                };
                onValueChange(stringValue, name, values);
            }
        };
        /**
         * Handle change event
         */
        var handleOnChange = function (event) {
            var _a = event.target, value = _a.value, selectionStart = _a.selectionStart;
            processChange(value, selectionStart);
            onChange && onChange(event);
        };
        /**
         * Handle focus event
         */
        var handleOnFocus = function (event) {
            onFocus && onFocus(event);
            return stateValue ? stateValue.length : 0;
        };
        /**
         * Handle blur event
         *
         * Format value by padding/trimming decimals if required by
         */
        var handleOnBlur = function (event) {
            console.log("[handleOnBlur]")
            var value = event.target.value;
            var valueOnly = cleanValue(__assign({ value: value }, cleanValueOptions));
            if (true || valueOnly === '-' || !valueOnly) {
                setStateValue('');
                onBlur && onBlur(event);
                return;
            }
            var fixedDecimals = fixedDecimalValue(valueOnly, decimalSeparator, fixedDecimalLength);
            var newValue = padTrimValue(fixedDecimals, decimalSeparator, decimalScale !== undefined ? decimalScale : fixedDecimalLength);
            var numberValue = parseFloat(newValue.replace(decimalSeparator, '.'));
            var formattedValue = formatValue(__assign(__assign({}, formatValueOptions), { value: newValue }));
            if (onValueChange) {
                onValueChange(newValue, name, {
                    float: numberValue,
                    formatted: formattedValue,
                    value: newValue,
                });
            }
            setStateValue(formattedValue);
            onBlur && onBlur(event);
        };
        /**
         * Handle key down event
         *
         * Increase or decrease value by step
         */
        var handleOnKeyDown = function (event) {
            var key = event.key;
            if (step && (key === 'ArrowUp' || key === 'ArrowDown')) {
                event.preventDefault();
                setCursor(stateValue.length);
                var currentValue = parseFloat(userValue !== undefined && userValue !== null
                    ? String(userValue).replace(decimalSeparator, '.')
                    : cleanValue(__assign({ value: stateValue }, cleanValueOptions))) || 0;
                var newValue = key === 'ArrowUp' ? currentValue + step : currentValue - step;
                if (min !== undefined && newValue < min) {
                    return;
                }
                if (max !== undefined && newValue > max) {
                    return;
                }
                var fixedLength = String(step).includes('.')
                    ? Number(String(step).split('.')[1].length)
                    : undefined;
                processChange(String(fixedLength ? newValue.toFixed(fixedLength) : newValue).replace('.', decimalSeparator));
            }
            onKeyDown && onKeyDown(event);
        };
        /**
         * Handle key up event
         *
         * Move cursor if there is a suffix to prevent user typing past suffix
         */
        var handleOnKeyUp = function (event) {
            var key = event.key, selectionStart = event.currentTarget.selectionStart;
            if (key !== 'ArrowUp' && key !== 'ArrowDown' && stateValue !== '-') {
                var suffix_1 = getSuffix(stateValue, { groupSeparator: groupSeparator, decimalSeparator: decimalSeparator });
                if (suffix_1 && selectionStart && selectionStart > stateValue.length - suffix_1.length) {
                    if (inputRef && typeof inputRef === 'object' && inputRef.current) {
                        var newCursor = stateValue.length - suffix_1.length;
                        inputRef.current.setSelectionRange(newCursor, newCursor);
                    }
                }
            }
            onKeyUp && onKeyUp(event);
        };
        /* istanbul ignore next */
        React.useEffect(function () {
            // prevent cursor jumping if editing value
            if (dirty &&
                stateValue !== '-' &&
                inputRef &&
                typeof inputRef === 'object' &&
                inputRef.current) {
                inputRef.current.setSelectionRange(cursor, cursor);
            }
        }, [stateValue, cursor, inputRef, dirty]);
        /**
         * If user has only entered "-" or decimal separator,
         * keep the char to allow them to enter next value
         */
        var getRenderValue = function () {
            if (userValue !== undefined &&
                userValue !== null &&
                stateValue !== '-' &&
                stateValue !== decimalSeparator) {
                return formatValue(__assign(__assign({}, formatValueOptions), { decimalScale: dirty ? undefined : decimalScale, value: String(userValue) }));
            }
            return stateValue;
        };
        var onBlurHandler = (e)=>{
            return ()=> handleOnBlur(e)
        }
        var onblur=(e) => setTimeout(onBlurHandler(e), 1)
        var inputProps = __assign({ type: 'text', inputMode: 'decimal', id: id,
            name: name,
            className: className, onChange: handleOnChange, onBlur: onblur, onFocus: handleOnFocus, onKeyDown: handleOnKeyDown, onKeyUp: handleOnKeyUp, placeholder: placeholder,
            disabled: disabled, value: getRenderValue(), ref: inputRef }, props);
        if (customInput) {
            var CustomInput = customInput;
            return React__default['default'].createElement(CustomInput, __assign({}, inputProps));
        }
        return React__default['default'].createElement("input", __assign({}, inputProps));
    });
    CurrencyInput.displayName = 'CurrencyInput';

    exports.default = CurrencyInput;
    exports.formatValue = formatValue;

    Object.defineProperty(exports, '__esModule', { value: true });

})));
//# sourceMappingURL=index.js.map
