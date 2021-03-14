class AddUserChatToUsersChats < ActiveRecord::Migration[6.1]
  def change
    add_reference :users_chats, :user, index: true
    add_reference :users_chats, :chat, index: true
  end
end
