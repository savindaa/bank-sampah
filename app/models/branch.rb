class Branch < ApplicationRecord
    include ValidatePhoneNumberUniquenessAcrossModels

    has_many :acct_transactions
    has_many :pick_requests
    
    validates :name, presence: true, length: { in: 3..50 }
    validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
    validates :address, presence: true
    has_secure_password
    validates :password, presence: true, length: { in: 6..20 }, allow_nil: true

    def self.from_token_request request
        phone_number = request.params["auth"] && request.params["auth"]["phone_number"]
        self.find_by phone_number: phone_number 
    end

    def formatting_name
        rand_number = rand(500..999).to_s
        self.update(name: "Bank " + self.name.to_s + " - " + rand_number)
    end
end
