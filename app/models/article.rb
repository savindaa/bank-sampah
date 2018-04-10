class Article < ApplicationRecord

    validates_presence_of :title, :body, :author, :source
    
end
