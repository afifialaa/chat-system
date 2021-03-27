class CreateUsersChats < ActiveRecord::Migration[6.1]
  def change
    create_table :userschats do |t|
      t.belongs_to :user
      t.belongs_to :chat

      t.timestamps
    end
  end
end
