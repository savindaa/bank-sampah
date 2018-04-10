class TrashWeight < ApplicationRecord
    belongs_to :need_detail, polymorphic: true

    validates_numericality_of :plastik, :kertas, :botol, :besi, :other

    def modify_transaction (need_detail)
        total_price = (self.plastik * 800).to_i + (self.kertas * 850).to_i + (self.botol * 500).to_i + (self.besi * 2300).to_i + (self.other * 500).to_i
        total_weight = self.plastik + self.kertas + self.botol + self.besi + self.other
        need_detail.update(amount: total_price)
        need_detail.update(point_received: total_weight.floor * 100)
    end

end