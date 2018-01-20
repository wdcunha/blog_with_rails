class UsersController < ApplicationController
before_action :find_user, only: [:show, :edit, :update, :destroy, :update_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up, #{@user.first_name}!"
      redirect_to home_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User changed successfully!'
      redirect_to home_path
    end
  end

  def edit_password
    @user = current_user
  end

  # def update_password
  #   @user = current_user
  #   if params[:current_password].empty?
  #     @user.errors.add(:current_password, "can't be empty")
  #     render 'edit_password'
  #   elsif @user.authenticate(password_params[:password] &&
  #         password_params[:new_password] != password_params[:current_password])
  #     @user.password = password_params[:new_password]
  #     if @user.save
  #       flash[:success] = "Password was changed successfully"
  #       redirect_to home_path
  #     end
  #   else
  #     flash[:danger] = "Failed"
  #     render 'edit_password'
  #   end
  # end

  def update_password
      @user = current_user

      if @user.authenticate(password_params[:current_password]) &&
        password_params[:new_password] != password_params[:current_password]
        @user.password = password_params[:new_password]
        @user.save!
        flash[:notice] = "Password was changed successfully"
        redirect_to home_path
       else
         flash[:alert] = "Wrong password"
         render :edit_password
       end
     end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  #  change password
  def password_params
      params.permit(:current_password, :new_password, :new_password_confirmation)
  end

  def find_user
    @user = User.find params[:id]
  end
end
