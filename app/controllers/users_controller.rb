class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			authenticate_service = Auth::UserAuthenticateService.new(@user.email, @user.password)
	    if user_id = authenticate_service.authenticate
	    	session[:user_id] = user_id
	      redirect_to users_path
	    else
	    	p 'user create faild!!'
	    end
	  else
	  	render login_path
		end
	end

	def index
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
