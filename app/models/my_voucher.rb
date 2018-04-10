class MyVoucher < ApplicationRecord
    belongs_to :voucher
    belongs_to :customer

    validate :point_availability

    def point_availability
        if Voucher.find(self.voucher_id).point_needed > Customer.find(self.customer_id).point
            errors.add(:point, 'Poin Anda kurang')
        end
    end

    def modify_customer_point
        customer = Customer.find(self.customer_id)
        voucher = Voucher.find(self.voucher_id)
        customer.update(point: customer.point - voucher.point_needed)
    end
end
