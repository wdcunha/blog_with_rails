class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id

      flash[:success] = 'Thank you for sign in!'
      redirect_to home_path
    else
      flash.now[:danger] = 'Wrong email or password!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to home_path, success: 'Signed Out!'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end

end
