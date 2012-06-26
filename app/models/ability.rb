class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      public_rules
    else
      @user = user
      logged_in_rules
    end
  end

private

  def logged_in_rules
  end


  def public_rules
  end

end
