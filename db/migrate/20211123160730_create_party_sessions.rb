class CreatePartySessions < ActiveRecord::Migration[6.0]
  def change
    create_table :party_sessions do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
