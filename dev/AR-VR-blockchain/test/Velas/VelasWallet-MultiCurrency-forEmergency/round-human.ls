add-spaces = (x)->
    x = x.toString!
    pattern = /(-?\d+)(\d{3})/
    while pattern.test x
        x := x.replace pattern, "$1,$2"
    x
module.exports = (value, config=null)->
    return \.. if not value?
    return \.. if value is \..
    [head, dec] = value.to-string!.split(\.)
    first-head = add-spaces head
    return "#{first-head}" if (dec ? "").length is 0
    decimals = config?decimals ? 4
    res = "#{first-head}.#{dec.substr 0, decimals}"
    res