class CreateLiveHotels < ActiveRecord::Migration
  def change
    create_table :live_hotels do |t|

      t.timestamps
    end
  end
end
