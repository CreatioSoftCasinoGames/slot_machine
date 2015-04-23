class AddIntervalAndPointsRequiredToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :interval, :integer
    add_column :tournaments, :points_required, :integer
  end
end
