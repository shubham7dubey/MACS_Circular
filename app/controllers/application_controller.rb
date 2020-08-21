class ApplicationController < ActionController::Base
	add_flash_types :info, :error, :warning, :success

	before_action :authenticate_user!, :except =>[:home,:contact]
rescue_from Exception, :with => :handle_exception

def handle_exception(error)

	flash[:error] = "#{error.message}"
	redirect_to group_group_home_path

end
def after_sign_up_path_for(resource)

	login_path
	flash[:success] = "Request for account verification has been sent successfully. You will receive mail of further update."
end	

def after_sign_in_path_for(resource)
	if current_user.isVerifiedByAdmin==0
		flash[:error] = "Since Your Account is not verified by admin"
		destroy_user_session_path
	elsif current_user.role=="admin"
		admin_page_new_path
	else
		notices_path
	end
end	

end
