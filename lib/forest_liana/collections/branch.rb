class Forest::Branch
    include ForestLiana::Collection

    collection :Branch

    action 'Block Branch'
    action 'Unblock Branch'
end