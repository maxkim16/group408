class LoginController < ApplicationController
	def index
		if session[:user_id]
			redirect_to '/main'
		end
	end

    # @user is the whole thing. Ex) @user => id:4, name: max, email:m@cpp.edu
    # session = [id=4, error = true, email: dd]
	def create
		# with account input, check in the db and return that user 
		@user = User.find_by_account(params[:login][:account])
		# authenticate in a built-in function
		# if the user exists in db, 
		if @user && @user.authenticate(params[:login][:password])
			session[:user_id] = @user.id  # save user id in session like id1, id2 
			redirect_to '/main'
		else
			#save the error message to session
			session[:error] = true
			redirect_to '/'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/'  # to log in page. Which is this page. It does not go to /main again. def index 
	end
end
