class AddVersionAndActiveInMathModels < ActiveRecord::Migration
  def change
  	add_column :math_models, :version, :string
  	add_column :math_models, :active, :boolean
  end
end
