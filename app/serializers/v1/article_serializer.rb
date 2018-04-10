class V1::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author, :source, :created_at, :updated_at

  def created_at
    object.created_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end

  def updated_at
    object.updated_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end
end
