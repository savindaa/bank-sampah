class Voucher < ApplicationRecord
    has_many :my_vouchers

    validates_presence_of :name, :category, :point_needed, :description
    
end
