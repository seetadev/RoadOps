export get-error-message = (err, result)->
    return null if not (err? or result?error) 
    err-message = 
        | result?error? => 
            error = result.description
            if error.index-of("Failed to fetch") then
                topic = (error.split(":").0 ? "")
                firstLetter = topic.substr(0, 1)
                topic = firstLetter.toUpperCase() + topic.substr(1);
            else
                error
        | err.toString().index-of("Insufficient funds for fee") > -1 =>
            "Not enough VLX Native balance to execute this operation.\nYou need at least 0.000005 VLX."
        | err.toString().index-of("Attempt to debit an account but found no record of a prior credit") > -1 =>
            "Not enough VLX Native balance to execute this operation.\nYou need at least 0.000005 VLX."
        |err? => 
            error = err.toString!
            if error.index-of("Failed to fetch") then
                topic = error
        | _ => "Error occured"
    return err-message