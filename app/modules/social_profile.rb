module SocialProfile

  extend ActiveSupport::Concern

  included do

    attr_accessible []

    belongs_to :user  # TODO , :inverse_of => self.name.underscore.pluralize

    default_scope includes([:user])

    scope :findable, where( 'findable = ?', true )

    validates_inclusion_of :findable,    :in => [false, true]
    validates_inclusion_of :publishable, :in => [false, true]

    validates_presence_of :user, :unless => Proc.new { |p| p.user_id.blank? }
    validates_presence_of :user_id, :unless => Proc.new { |p| p.user.nil? }

    validates_uniqueness_of :uid

  end

end
