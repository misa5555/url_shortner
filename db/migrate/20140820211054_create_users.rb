class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.timestamp
    end
    add_index :users, :email
  end

end
