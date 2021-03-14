class RenameUsersChats < ActiveRecord::Migration[6.1]
  def change
    rename_table :users_chats, :userschats
  end
end
