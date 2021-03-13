class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :token, null: false, index: {unique: true}
      t.string :name
      t.integer :chats_count

      t.timestamps
    end
  end
end
