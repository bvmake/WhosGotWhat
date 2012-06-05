class Role < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users

  validates :name, :presence => true, :uniqueness => true

  class << self

    def restricted_roles
      where :name => "role_admin"
    end
  end


  def restricted?
    self.class.restricted_roles.include? self
  end


end
