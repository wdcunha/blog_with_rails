class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

  def new
  end

  def index

  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = "Email sent with the reset instuctions!"
      # redirect_to home_path
      redirect_to password_resets_path
    else
      flash[:danger] = "Email address not found!"
      render 'new'
    end
  end

  def edit
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless (@user &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to home_path
    end
  end
end
