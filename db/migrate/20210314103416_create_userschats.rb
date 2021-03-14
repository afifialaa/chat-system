class CreateUserschats < ActiveRecord::Migration[6.1]
  def change
    create_table :userschats do |t|

      t.timestamps
    end
  end
end
