class RegisterController < ApplicationController


	def index
		
		#check if the user is already login in
		if session[:user_id]
			redirect_to '/main'
		end

		@users = User.all
		@user = User.new   # create a new user in db.
	end
    

	def create
		# (user_params) parameters include all attributese in user's table: "account,password_digest",
		@user = User.new(user_params)   # create a user 

        # session = current user 
		if @user.save   # save to db. Permanent 
			session[:user_id] = @user.id  # cookies(temporary): session is like array
			redirect_to '/main'
		else
			session[:error] = true
			redirect_to '/register'
		end

	end

	private 

		def user_params
			params.require(:user).permit(:account, :password, :password_confirmation)
		end
end
