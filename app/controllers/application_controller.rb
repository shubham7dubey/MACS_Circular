class ApplicationController < ActionController::Base

def after_sign_up_path_for(resource)
	login_path
end	

def after_sign_in_path_for(resource)
	if current_user.role=="admin"
		admin_page_new_path
	else
		notices_path
	end
end	

end
