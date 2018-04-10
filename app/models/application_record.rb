class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  VALID_PHONE_REGEX = /\A(08)([0-9]{8,10})\z/  
end
