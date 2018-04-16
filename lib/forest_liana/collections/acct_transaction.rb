class Forest::AcctTransaction
    include ForestLiana::Collection

    collection :AcctTransaction
    collection :TrashDetail

    action 'Create', fields: [
        { field: 'item_name', type: 'String', isRequired: true },
        { field: 'weight', type: 'Number', isRequires: true }
    ]


    belongs_to :trash_detail, reference: 'TrashDetail.id' do
        object.trash_detail.id
    end
end