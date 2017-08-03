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
end
