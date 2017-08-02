class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			authenticate_service = Auth::UserAuthenticateService.new(@user.email, @user.password)
	    if authenticate_service
	      session[:user_id] = user.id
	      redirect_to users_path
	    else
	    	p 'user create faild!!'
	    end
	  else
	  	render "new"
		end
	end

	def index
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
