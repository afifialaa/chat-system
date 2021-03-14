class CreateUsersChats < ActiveRecord::Migration[6.1]
  def change
    create_table :users_chats do |t|

      t.timestamps
    end
  end
end
