class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :name
      t.text :description
      t.integer :theme_id

      t.timestamps
    end
  end
end
