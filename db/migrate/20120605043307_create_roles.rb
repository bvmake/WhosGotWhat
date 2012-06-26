class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :null => false
    end
    create_table :roles_users, :id => false do |t|
      t.references :user, :null => false
      t.references :role, :null => false
    end
    add_index :roles_users, [:user_id,:role_id], :unique => true
    Role.create :name => 'role_admin'
    Role.create :name => 'invitation_approver'
    STDERR.puts 'Please add users to the "invitation_approver" role via the rails console'
  end
end
