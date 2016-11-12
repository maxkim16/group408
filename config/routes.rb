Rails.application.routes.draw do

    # HTTP Helpers 
     
	# GET
	get "/register", to: "register#index"
	get "/main", to: "main#index", as: "main"
	get "/main/class_schedule", to: "main#schedule", as: "schedule"
	get "/main/personal_note", to: "main#note", as: "note"
	get "/main/gpa_calculator", to: "main#calculator", as: "calculator"

	# POST
	post "/register", to: "register#create"  # create action in register controller
	post "/", to: "login#create"
	post "/main/class_schedule", to: "main#schedule_create"  # go to schedule_create in main controller
	post "/main/personal_note", to: "main#note_create"
	
	# DELETE (for convenience, using GET method instead)
	get "/logout", to: "login#destroy"   # when log out, go to destroy action in login_controller.rb
	get "/main/class_schedule/:id", to: "main#schedule_destroy"
	get "/main/personal_note/:id", to: "main#note_destroy"

	root "login#index"
end
