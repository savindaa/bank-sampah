class Admin < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { in: 6..20 }
end
