class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :short_title
      t.string :location
      t.string :image

      t.timestamps
    end
  end
end
