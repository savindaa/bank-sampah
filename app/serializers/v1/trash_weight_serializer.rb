class V1::TrashWeightSerializer < ActiveModel::Serializer
  attributes :id, :plastik, :kertas, :botol, :besi, :other, :need_detail_id
end
