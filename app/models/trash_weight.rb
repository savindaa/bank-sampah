class TrashWeight < ApplicationRecord
    belongs_to :need_detail, polymorphic: true, optional: true

    validates_numericality_of :plastik, :kertas, :botol, :besi, :other
end