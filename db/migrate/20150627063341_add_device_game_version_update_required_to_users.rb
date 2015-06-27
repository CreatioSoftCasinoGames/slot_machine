class AddDeviceGameVersionUpdateRequiredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device, :string, default: ""
    add_column :users, :update_required, :boolean, default: false
    add_column :users, :game_version, :string, default: ""
  end
end
