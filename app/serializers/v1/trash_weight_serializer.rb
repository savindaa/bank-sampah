class V1::TrashWeightSerializer < ActiveModel::Serializer
  attributes :id, :plastik, :kertas, :botol, :besi, :other
end
