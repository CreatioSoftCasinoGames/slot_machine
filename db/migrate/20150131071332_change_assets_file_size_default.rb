class ChangeAssetsFileSizeDefault < ActiveRecord::Migration
  def change
  	change_column_default :assets, :file_file_size, 0
  end
end
