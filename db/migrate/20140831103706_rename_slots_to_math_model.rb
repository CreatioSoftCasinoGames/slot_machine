class RenameSlotsToMathModel < ActiveRecord::Migration

	def self.up
    rename_table :slots, :math_models
    rename_column :pay_lines, :slot_id, :math_model_id
    rename_column :pay_tables, :slot_id, :math_model_id
    rename_column :reels, :slot_id, :math_model_id
    rename_column :stamps, :slot_id, :math_model_id
  end

  def self.down
    rename_table :math_models, :slots
    rename_column :pay_lines, :math_model_id, :slot_id
    rename_column :pay_tables, :math_model_id, :slot_id
    rename_column :reels, :math_model_id, :slot_id
    rename_column :stamps, :math_model_id, :slot_id
  end

end
