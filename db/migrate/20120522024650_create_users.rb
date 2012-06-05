class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :limit => 60, :null => false
      t.string :last_name, :limit => 60, :null => false
      t.string :email, :null => false
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
