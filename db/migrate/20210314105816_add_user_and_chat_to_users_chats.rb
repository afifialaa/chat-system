class AddUserAndChatToUsersChats < ActiveRecord::Migration[6.1]
  def change
    add_reference :userschats, :user, index: true
    add_reference :userschats, :chat, index: true
  end
end
