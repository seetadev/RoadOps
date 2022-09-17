require! {
    \./navigate.ls
    \./seed.ls : seedmem
    \../web3t/providers/deps.js : { bip39 }
    \./pages/confirmation.ls : { alert }
    \prelude-ls : { words, map, filter, join }
    \./get-lang.ls
}
clean = ->
    it.match(/[a-z]+/)?0
fix =
    words >> (map clean) >> (filter (?)) >> (join " ")
not-in-dictionary = (word)->
    word not in bip39.wordlists.EN
module.exports = (store, web3t)->
    return null if not store? or not web3t?
    lang = get-lang store
    generate-seed = ->
        /* Uncomment below for supporting valid 256-bits 24-seed-words mnemonic (must be fixed on all wallets types at the same time) */
        seed = bip39.generate-mnemonic(256)
        #seed = bip39.generate-mnemonic! + ' ' + bip39.generate-mnemonic!
        store.current.seed-words = seed.split(' ').map(-> { part: it })
        store.current.seed-generated = yes
    next = ->
        navigate store, web3t, \:init
    verify-seed = (cb)->
        empty =
            store.current.seed-words
                |> filter (.part.trim!.length is 0)
        if empty.length is not 0
            store.current.alert = "Please fill all words"
            return cb "cancelled"
        # wrong =
        #     store.current.seed-words
        #         |> map (.part)
        #         |> filter not-in-dictionary
        # return cb null if wrong.length is 0
        # res <- confirm store, "Some words do not match the dictionary. Do you want to continue?"
        /* First check mnemonic generated with 256 bits length seed */
        try
            bip39.mnemonic-to-entropy store.current.seed-words.map(-> it.part).join(" ")
            return cb null
        catch e
        /* If check fails continue to verify mnemonic generated with two 128 bits length seed phrases */
        try
            for i from 0 to store.current.seed-words.length-11 by 12
                bip39.mnemonic-to-entropy store.current.seed-words.slice(i, i+12).map(-> it.part).join(" ")
            cb null
        catch
            alert store, "Seed phrase checksum not match. Please try again."
            store.current.page = \newseedrestore
    save = ->
        err <- verify-seed
        return if err?
        seedmem.mnemonic = store.current.seed-words.map(-> it.part).join(' ')
        store.current.saved-seed = yes
        seedmem.set seedmem.mnemonic
        next!
    { save, generate-seed, next }