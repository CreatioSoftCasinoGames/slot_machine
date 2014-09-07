class MathModelSerializer < ActiveModel::Serializer

  attributes :name, :pay_line_coordinates, :reel_series, :free_spins_multipliers, :num_free_spins, :wild_type, :is_irregular, :size_x, :size_y, :is_special
  has_many :pay_tables
  has_many :symbols
  
end
