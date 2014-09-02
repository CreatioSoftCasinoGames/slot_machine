class MathModelSerializer < ActiveModel::Serializer

  attributes :name, :pay_line_coordinates, :reel_series
  has_many :pay_tables
  
end
