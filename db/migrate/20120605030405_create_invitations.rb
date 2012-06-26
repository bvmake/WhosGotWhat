class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.datetime :accepted_at
      t.string :contact, :null => false, :limit => 80
      t.string :network, :null => false, :limit => 20
      t.references :sender
      t.datetime :sent_at
      t.string :state, :null => false, :limit => 20
      t.string :token, :null => false
    end
    add_index :invitations, :accepted_at
    add_index :invitations, [:network,:token]
    add_index :invitations, :token
    add_column :users, :invitation_id, :integer

  end
end
