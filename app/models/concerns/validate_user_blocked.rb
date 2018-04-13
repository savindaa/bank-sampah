module ValidateUserBlocked
    extend ActiveSupport::Concern

    included do
        validate :is_it_blocked
    end

    private

    def is_it_blocked
        if Branch.find(self.branch_id).blocked == true
            errors.add(:bank, 'telah di-block')
        elsif Customer.find(self.customer_id).blocked == true
            errors.add(:nasabah, 'telah di-block')
        end
    end

end