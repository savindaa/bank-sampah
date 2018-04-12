class PickRequest < ApplicationRecord
    include Modifyable

    belongs_to :customer
    belongs_to :branch

    has_one :trash_weight, as: :need_detail, dependent: :destroy

    accepts_nested_attributes_for :trash_weight, allow_destroy: true

    scope :active, -> { where(status: ['1', '2']) }
    scope :history, -> { where(status: ['3', '4']) }
    scope :newest, -> { order(updated_at: :desc) }

    validates_presence_of :customer_address, :branch_name
    validate  :is_it_blocked

    def is_it_blocked
        if Branch.find(self.branch_id).blocked == true
            errors.add(:branch_name, 'Bank telah di-block')
        elsif Customer.find(self.customer_id).blocked == true
            errors.add(:customer_phone_number, 'Nasabah telah di-block')
        end
    end

    def request_setting (current_customer)
        self.customer_id = current_customer.id
        self.branch_name = Branch.find(self.branch_id).name
        self.pr_id = rand(20..29).to_s + rand(10..99).to_s + rand(1_000_000..9_999_999).to_s
        self.modify_transaction
    end
end
