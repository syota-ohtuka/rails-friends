class VoicesController < ApplicationController
  def create
  	if !params[:text].empty?
  		@voice = Voice.create(text: params[:text], user_id: current_user.id)
  	end
		redirect_to users_path
  end

  private
	def login_check
    if session[:user_id].nil?
    	redirect_to login_path
    end
	end
end
