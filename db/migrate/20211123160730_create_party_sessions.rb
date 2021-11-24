class CreatePartySessions < ActiveRecord::Migration[6.0]
  def change
    create_table :party_sessions do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :address
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
