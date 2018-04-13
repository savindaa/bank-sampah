class Village < ActiveRecord::Base
    self.primary_key = 'code'

    belongs_to :district, foreign_key: :district_code
end
