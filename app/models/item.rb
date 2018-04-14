class Item < ApplicationRecord
    has_many :trash_details, foreign_key: 'item_name'

    validates :name, uniqueness: { case_sensitive: false }

    def self.import!
        CSV.foreach(Rails.root.join('lib/data/items.csv'), headers: true) do |row|
            Item.create! row.to_hash.slice('name', 'price')
            print '.'
        end
    end
end
