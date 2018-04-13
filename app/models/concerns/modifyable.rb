module Modifyable
    extend ActiveSupport::Concerns

    PLASTIK_PRICE = 800
    KERTAS_PRICE = 850
    BOTOL_PRICE = 500
    BESI_PRICE = 2300
    OTHER_PRICE = 500

    # POINT_MULTIPLICATION = 100

    def modify_transaction

        plastik_weight = self.trash_weight.plastik
        kertas_weight = self.trash_weight.kertas
        botol_weight = self.trash_weight.botol
        besi_weight = self.trash_weight.besi
        other_weight = self.trash_weight.other

        if self.trash_weight.plastik == nil
            plastik_weight = 0.0
        end

        if self.trash_weight.kertas == nil
            kertas_weight = 0.0
        end

        if self.trash_weight.botol == nil
            botol_weight = 0.0
        end

        if self.trash_weight.besi == nil
            besi_weight = 0.0
        end

        if self.trash_weight.other == nil
            other_weight = 0.0
        end

        total_price = (plastik_weight * PLASTIK_PRICE).to_i + (kertas_weight * KERTAS_PRICE).to_i + (botol_weight * BOTOL_PRICE).to_i + (besi_weight * BESI_PRICE).to_i + (other_weight * OTHER_PRICE).to_i
        total_weight = plastik_weight + kertas_weight + botol_weight + besi_weight + other_weight
        self.update(amount: total_price)
        # self.update(point_received: total_weight.floor * POINT_MULTIPLICATION)
    end
end