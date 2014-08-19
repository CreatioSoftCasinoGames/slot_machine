class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :resource_id
      t.string :resource_type
      t.string :label
      t.attachment :file

      t.timestamps
    end
  end
end
