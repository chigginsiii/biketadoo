class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user and @user.authenticate(user_params[:password])
      log_in @user
      redirect_to @user
    else
      flash.now[:alert] = "Invalid email/password combo"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end

end
