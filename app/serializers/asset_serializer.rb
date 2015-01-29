class AssetSerializer < ActiveModel::Serializer
  attributes :id, :version, :file_file_size, :file_updated_at, :country, :bundle_type, :url
end
