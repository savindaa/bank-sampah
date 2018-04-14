module Modifyable
    extend ActiveSupport::Concern

    included do
        before_save :record_amount 
    end

    # POINT_MULTIPLICATION = 100

    private

    def record_amount
        self.amount = trash_details.reject(&:marked_for_destruction?).sum(&:total_price)
        # total_weight = trash_details.reject(&:marked_for_destruction?).sum(&:weight)
        # self.point_received = total_weight.floor * POINT_MULTIPLICATION
    end
end