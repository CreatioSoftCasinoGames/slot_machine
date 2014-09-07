class AddConfidToMathModel < ActiveRecord::Migration
  def change
  	add_column :math_models, :free_spins_multipliers, :integer, default: 0
		add_column :math_models, :num_free_spins, :integer, default: 0
		add_column :math_models, :wild_type, :string
		add_column :math_models, :is_irregular, :boolean, default: false
		add_column :math_models, :is_special, :boolean, default: false
		add_column :math_models, :size_x, :integer, default: 3
		add_column :math_models, :size_y, :integer, default: 3
  end
end
