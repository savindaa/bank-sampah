class TrashDetail < ApplicationRecord
    belongs_to :item, foreign_key: 'item_name', optional: true
    belongs_to :need_detail, polymorphic: true, optional: true
end
