class Image
  include ActiveModel::Model
  include Aws::Record

  string_attr :id, hash_key: true
  string_attr :url
end
