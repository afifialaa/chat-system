class AddUserToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :user, index: true
  end
end
