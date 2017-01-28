class Admin::UsersController < Admin::BaseController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    authorize @users
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      flash[:success] = t('messages.created', model: @user.class.model_name.human)
      redirect_to [:admin, @user]
#     redirect_to polymorphic_url([:admin, @user], locale: params[:locale]), notice: t('messages.created', model: @user.class.model_name.human)
    else
      render :new
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:success] = t('messages.updated', model: @user.class.model_name.human)
      redirect_to [:admin, @user]
#     redirect_to polymorphic_url([:admin, @user], locale: params[:locale]), notice: t('messages.updated', model: @user.class.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    flash[:success] = t('messages.deleted', model: @user.class.model_name.human)
    redirect_to admin_users_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_user
      @user = User.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def user_params
      params.require(:user).permit(:role, :last_name, :first_name, :email, :password_digest, :remember_digest, :status, :password, :password_confirmation)
    end
end
