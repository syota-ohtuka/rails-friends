class SessionsController < ApplicationController
	def new
	end

	def create
    authenticate_service = Auth::UserAuthenticateService.new(params[:email], params[:password])
    if authenticate_service
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = 'emailまたはpasswordが間違っています'
      render "new"
    end
	end
end
