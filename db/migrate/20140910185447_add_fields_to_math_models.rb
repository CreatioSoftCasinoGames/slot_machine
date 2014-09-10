class AddFieldsToMathModels < ActiveRecord::Migration

  def up
  	add_column :math_models, :num_pay_lines, :integer
  	change_column :math_models, :num_free_spins, :string
  end

  def down
  	remove_column :math_models, :num_pay_lines
  	change_column :math_models, :num_free_spins, :integer
  end

end
