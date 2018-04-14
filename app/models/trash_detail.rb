class TrashDetail < ApplicationRecord
    after_save :modify_tr

    belongs_to :item, foreign_key: 'item_name', optional: true
    belongs_to :need_detail, polymorphic: true, optional: true

    def modify_tr
        @price = Item.find_by(name: self.item_name).price
        @sum = (self.weight * @price).to_i
        if need_detail_type == "AcctTransaction"
            @object = AcctTransaction.find(self.need_detail_id)
            @customer = Customer.find(@object.customer_id) if @object
            @customer.update(balance: @customer.balance + @sum)
        elsif need_detail_type == "PickRequest"
            @object = PickRequest.find(self.need_detail_id)
        end
        @object.update(amount: @object.amount + @sum)
    end
end
