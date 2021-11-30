class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.references :party_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
