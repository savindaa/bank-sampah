class TrashDetail < ApplicationRecord
    after_validation :calculate_price

    belongs_to :item, foreign_key: 'item_name', optional: true
    belongs_to :need_detail, polymorphic: true, optional: true

    def calculate_price
        if !Item.find_by(name: self.item_name).nil?
            @price = Item.find_by(name: self.item_name).price
            self.total_price = (self.weight * @price).to_i
        else
            errors.add(:sampah, 'tidak ada.')
        end
    end
end
