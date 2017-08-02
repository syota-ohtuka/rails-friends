class Auth::UserAuthenticateService
	def initialize(email, unencrypted_password)
		@user = User.find_by(email: email)
		@unencrypted_password = unencrypted_password
	end

	def authenticate
		return false unless @user
    if BCrypt::Password.new(@user.password_digest) == unencrypted_password
    	return @user.id
    else
    	return false
    end
	end

	private
		attr_reader :user, :unencrypted_password

		def user_password
	    @user_password ||= -> do
	      BCrypt::Password.new(user.password_digest)
			end
		end
end