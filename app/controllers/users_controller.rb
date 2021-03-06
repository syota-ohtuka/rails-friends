class UsersController < ApplicationController
	before_action :login_check, only: %i(index edit update destroy)
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
	    	redirect_to login_path
	    end
		end
	end

	def index
		@voices = current_user.voices
		@target_user = User.find(current_user.id).following
		if !@target_user.nil?
		@target_user.each do |user|
			@voices += user.voices
			end
		end
		@voices_res = @voices.sort { |aa, bb| bb.created_at <=> aa.created_at }
	end

	def show
		@show_user = User.find(params[:id])
		@voices = @show_user.voices
		@voices_res = @voices.sort { |aa, bb| bb.created_at <=> aa.created_at }
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

	def follow
		@user = User.find(params[:id])
		@follows = User.find(params[:id]).following
	end

	def follower
		@user = User.find(params[:id])
		@followers = User.find(params[:id]).followed
	end


	private
	def user_params
		params.require(:user).permit(:name, :email, :search_word, :password, :password_confirmation)
	end

	def login_check
    if session[:user_id].nil?
    	redirect_to login_path
    end
	end

	def permission_check
		if current_user.id != params[:id].to_i
			redirect_to user_path(params[:id]), flash: { denger: '権限がありません。'}
		end
	end
end
