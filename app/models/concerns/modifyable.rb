module Modifyable
    extend ActiveSupport::Concerns

    def modify_transaction
        if self.trash_weight.plastik == nil
            self.trash_weight.plastik = 0.0
        end

        if self.trash_weight.kertas == nil
            self.trash_weight.kertas = 0.0
        end

        if self.trash_weight.botol == nil
            self.trash_weight.botol = 0.0
        end

        if self.trash_weight.besi == nil
            self.trash_weight.besi = 0.0
        end

        if self.trash_weight.other == nil
            self.trash_weight.other = 0.0
        end

        total_price = (self.trash_weight.plastik * 800).to_i + (self.trash_weight.kertas * 850).to_i + (self.trash_weight.botol * 500).to_i + (self.trash_weight.besi * 2300).to_i + (self.trash_weight.other * 500).to_i
        total_weight = self.trash_weight.plastik + self.trash_weight.kertas + self.trash_weight.botol + self.trash_weight.besi + self.trash_weight.other
        self.update(amount: total_price)
        self.update(point_received: total_weight.floor * 100)
    end
end