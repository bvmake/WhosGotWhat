class User < ActiveRecord::Base

  attr_accessible :email, :first_name, :last_name

  belongs_to :invitation, :dependent => :destroy, :inverse_of => :recipient

  copies_omniauth :attributes => { :email => %w(info email),
                                   :first_name => %w(info first_name),
                                   :last_name => %w(info last_name)
                                 },
                  :options => { :skip_provider_check => true }

  has_one :facebook_profile, :dependent => :destroy, :inverse_of => :user

  validates :first_name, :presence => true
  validates :invitation, :presence => true
  validates :last_name, :presence => true


  class << self

    def from_omniauth(omniauth)
      return nil unless omniauth
      profile = omniauth_find_by_social_profile omniauth["provider"], omniauth["uid"]
      if profile
        user = profile.user
      else
        user = new
        profile = user.send("build_#{omniauth['provider']}_profile")
        user.build_invitation :network => 'email',
                              :contact => omniauth['info']['email']
      end
      profile.respond_to?(:copy_from_omniauth) && profile.copy_from_omniauth(omniauth)
      user.copy_from_omniauth(omniauth)
      user.save && user
    end

  private

    def omniauth_find_by_social_profile(provider,uid)
      social_profile_name      = "#{provider}_profile"
      social_profile_tablename = social_profile_name.tableize
      social_profile_class     = social_profile_name.classify.constantize
      social_profile = social_profile_class.find_by_uid(uid)
      social_profile
    end

  end


  def name
    "#{first_name} #{last_name}"
  end

end
