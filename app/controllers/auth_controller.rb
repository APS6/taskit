class AuthController < ApplicationController
  def new
  	@user = User.new
  end
  def login
    
  end

  def create
  	_user = User.find_by(email: params[:email])
  	if _user.present? 
  		if _user.authenticate(params[:password])
  			session[:user_id] = _user.id
  			redirect_to tasks_path
  		else
  			flash[:alert] = "Invalid password"
  			render :login
  		end
  	else
  		@user = User.new(user_params)
  		if @user.save
  			session[:user_id] = @user.id
  			redirect_to tasks_path
  		else
  			render :new
  		end
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end