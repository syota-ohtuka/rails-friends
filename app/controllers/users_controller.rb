class UsersController < ApplicationController
	before_action :login_check, only: %i(index new edit create update destroy)
	before_action :permission_check, only: %i(edit)
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

	def show
		@show_user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to @user
    else
        render 'edit'
    end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def login_check
    if session[:user_id].nil?
    	redirect_to login_path
    end
	end

	def permission_check
		p current_user.id
		p params[:id].to_i
		if current_user.id != params[:id].to_i
			redirect_to user_path(params[:id]), flash: { denger: '権限がありません。'}
		end
	end
end
