class SessionsController < ApplicationController
	def new
	end

	def create
    authenticate_service = Auth::UserAuthenticateService.new(params[:email], params[:password])
    if user_id = authenticate_service.authenticate
    	session[:user_id] = user_id
      redirect_to users_path
    else
      flash.now[:danger] = 'emailまたはpasswordが間違っています'
      render "new"
    end
	end

	def destroy
		session[:user_id] = nil
    redirect_to login_path
	end
end
