class FriendsController < ApplicationController
	def index
		@result = ""
	end

	def search
		@search_user = User.find_by(search_word: params[:search_word])
		if @search_user.nil?
			flash[:error] = "no hit..."
		end
		render "index"
	end

	def create
		to_user_id = params[:to_user_id]
		if current_user.id != to_user_id
			@friend = Friend.create(from_user_id: current_user.id, to_user_id: to_user_id)
		else
			flash[:notice] = "処理エラー"
		end
		redirect_to user_path(to_user_id)
	end

	def destroy
		to_user_id = params[:to_user_id]
		@friend = Friend.find_by(from_user_id: current_user, to_user_id: to_user_id)
		if @friend
			@friend.destroy
		else
			flash[:notice] = "処理エラー"
		end
		redirect_to user_path(to_user_id)
	end
end
