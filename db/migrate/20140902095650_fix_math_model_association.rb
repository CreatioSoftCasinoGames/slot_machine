class FixMathModelAssociation < ActiveRecord::Migration

  def up
  	rename_column :math_models, :game_id, :machine_id
  end

  def down
  	rename_column :math_models, :machine_id, :game_id
  end

end
