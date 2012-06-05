class CreateFacebookProfiles < ActiveRecord::Migration
  def change
    create_table :facebook_profiles do |t|
      t.string :email, :null => false
      t.boolean :findable, :null => false, :default => true
      t.string :first_name, :null => false, :limit => 60
      t.text :image_url
      t.string :last_name, :null => false, :limit => 60
      t.string :locale, :limit => 10
      t.string :middle_name, :limit => 60
      t.boolean :publishable, :null => false, :default => true
      t.integer :timezone
      t.string :token, :null => false
      t.string :uid, :null => false
      t.text :profile_url
      t.references :user, :null => false
    end
    add_index :facebook_profiles, :email, :unique => true
    add_index :facebook_profiles, :findable
    add_index :facebook_profiles, :uid, :unique => true
    add_index :facebook_profiles, :user_id
  end
end

