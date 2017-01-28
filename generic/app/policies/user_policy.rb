### This policy is special!

class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.sysadmin?
  end

  def show?
    @current_user.sysadmin? || @current_user.admin?|| @current_user == @user
  end

  def create?
    @current_user.sysadmin?
  end

  def new?
    create?
  end

  def edit?
    @current_user.sysadmin? || @current_user == @user
  end

  def update?
    @current_user.sysadmin? || @current_user == @user
  end

  def destroy?
    @current_user.sysadmin?
  end
end