class AcctTransaction < ApplicationRecord
    
    # include Modifyable
    
    include ValidateUserBlocked

    before_save :record_amount

    belongs_to :customer
    belongs_to :branch

    has_many :trash_details, as: :need_detail, dependent: :destroy

    accepts_nested_attributes_for :trash_details, allow_destroy:true

    scope :active, -> { where(status: "1") }
    scope :history, -> { where(status: ["2", "3"]) }
    scope :newest, -> { order(updated_at: :desc) }

    validates :amount, presence: true, numericality: { only_integer: true }
    validates :branch_name, presence: true
    validates :customer_phone_number, presence: true
    validate  :funds_availability
    validate  :withdraw_amount_term

    # keterangan:
    # transaction_type_id = 1 , transaction_type_name = setoran (deposit)
    # transaction_type_id = 2 , transaction_type_name = penarikan (withdraw)

    def record_amount
        if self.transaction_type_id == "1"
            self.amount = trash_details.reject(&:marked_for_destruction?).sum(&:total_price)
        end
    end

    def funds_availability
        if self.transaction_type_id == "2" && self.amount > Customer.find(self.customer_id).balance
            errors.add(:amount, 'Saldo Anda kurang')
        end
    end

    def withdraw_amount_term
        if self.transaction_type_id == "2"
            if self.amount < 50_000
                errors.add(:amount, 'Minimum penarikan adalah Rp 50.000,-')
            elsif self.amount%100 != 0
                errors.add(:amount, 'Penarikan harus kelipatan Rp 100,-')
            end
        end
    end

    def deposit_setting (current_branch)
        self.branch_id = current_branch.id
        self.branch_name = current_branch.name
        self.customer_id = Customer.find_by(phone_number: self.customer_phone_number).id
        self.tr_id = rand(10..19).to_s + rand(10-49).to_s + rand(1_000_000..9_999_999).to_s
        self.transaction_type_id = "1"
        self.adjust_balance
        self.update(status: "2")
    end

    def withdraw_setting (current_customer)
        self.customer_id = current_customer.id
        self.customer_phone_number = current_customer.phone_number
        self.branch_name = Branch.find(self.branch_id).name
        self.tr_id = rand(10..19).to_s + rand(50-99).to_s + rand(1_000_000..9_999_999).to_s
        self.transaction_type_id = "2"
        self.adjust_balance
    end

    def modify_acct_balance
        customer = Customer.find(self.customer_id)
        branch = Branch.find(self.branch_id)
        case self.transaction_type_id
            when "1"
              customer.update(balance: customer.balance + self.amount)
              # customer.update(point: customer.point + self.point_received)
              branch.update(balance: branch.balance + self.amount)
            when "2"
              customer.update(balance: customer.balance - self.amount)
              branch.update(balance: branch.balance - self.amount)
        end
    end

    def adjust_balance
        case self.transaction_type_id
          when "1"
              self.adjusted_bal = Customer.find(self.customer_id).balance + self.amount
          when "2"
              self.adjusted_bal = Customer.find(self.customer_id).balance - self.amount
        end
    end
end