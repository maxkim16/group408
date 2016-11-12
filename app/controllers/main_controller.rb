# logic part like when you click something, then something happens

class MainController < ApplicationController
	#check before rendering action
	before_action :check_login, only: [:index, :schedule, :note, :calculator]

	# GET for main menu page
	def index
		@user = load_user
		@schedules = Schedule.all
		@notes = Note.all  ####################################################################
	end

	# GET for class schedule page
	def schedule
		@user = load_user      # private. at the very bottom
		@schedules = Schedule.all      ## 
		@schedule = Schedule.new       ## 
	end

	# POST for class schedule
	def schedule_create
		# schedule_params parameters include: user id, professor, etc. go to schedule.html
		@schedule = Schedule.new(schedule_params)    # saving a new object in db

		if @schedule.save
			redirect_to '/main/class_schedule'
		else
			#handle error message here
			redirect_to '/main/class_schedule'
		end
	end

	# DELETE for class schedule
	def schedule_destroy
		@schedule = Schedule.find(params[:id])
		@schedule.destroy
		redirect_to '/main/class_schedule'
	end

######################################################################################################


	# GET(read) for personal note page
	def note
		@user = load_user
		@notes = Note.all
		@note = Note.new
	end

    # Create a new row in Note tables
	# POST(create) for class note. When you click "Submit"
	def note_create
		@note = Note.new(note_params)

		if @note.save
			redirect_to '/main/personal_note'
		else
			#handle error message here
			redirect_to '/main/personal_note'
		end
	end

	# DELETE for class note
	def note_destroy
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to '/main/personal_note'
	end

######################################################################################################



















	# GET for gpa calculator page
	def calculator
		@user = load_user
	end

	'''
	other private helper methods
	'''
	private
		#check if the user logged in
		def check_login
			if session[:user_id] == nil  # if not logged in
				redirect_to '/'   # go back to register page 
			end
		end

		#load the user info
		def load_user
			User.find_by_id(session[:user_id])   # return your info: id, name, etc. find_by_id is built-in function
		end

		#permission for POST
		def schedule_params
			params.require(:schedule).permit(:user, :professor, :classname, :classroom, :day, :hour, :minute, :hour_end, :minute_end)
		end

		def note_params
			params.require(:note).permit(:user,:month, :day, :content)
		end
end
