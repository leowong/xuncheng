class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      if user.role?(:author)
        can :create, [Topic, Reply, Avatar]
      end
    end
  end
end
