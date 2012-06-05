class FacebookProfile < ActiveRecord::Base

  include SocialProfile

  copies_omniauth :attributes => { :email => %w(info email),
                                   :first_name => %w(info first_name),
                                   :image_url => %w(info image),
                                   :last_name => %w(info last_name),
                                   :locale => %w(extra raw_info locale),
                                   :middle_name => %w(extra raw_info middle_name),
                                   :timezone => %w(extra raw_info timezone),
                                   :profile_url => %w(info urls Facebook)
                                }

  validates_presence_of :email, :first_name, :last_name, :token, :uid

  validates_uniqueness_of :email

  def name
    "#{first_name} #{middle_name} #{last_name}"
  end


end
