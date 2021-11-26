class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :confirm_availability, default: false
      t.boolean :confirm_arrival, default: false
      t.references :party_session, null: false, foreign_key: true
      t.timestamps
    end
  end
end
