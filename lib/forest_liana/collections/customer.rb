class Forest::Customer
    include ForestLiana::Collection

    collection :Customer

    action 'Block Customer'
    action 'Unblock Customer'
end