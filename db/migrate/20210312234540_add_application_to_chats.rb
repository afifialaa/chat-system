class AddApplicationToChats < ActiveRecord::Migration[6.1]
  def change
    add_reference :chats, :application, index: true
  end
end
