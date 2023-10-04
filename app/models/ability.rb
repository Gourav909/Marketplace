# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :all if user.admin?
    if user.user?
      can :read, :all
      can :get_current_user, User
      can [:create, :destroy, :read], FavouriteProperty
      cannot [:update, :destroy, :create], Property
    end
  end
end
