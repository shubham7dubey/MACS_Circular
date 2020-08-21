class RegistrationsController < Devise::RegistrationsController
  rescue_from Exception, :with => :handle_exception

  def handle_exception(error)

    flash[:error] = "#{error.message}"
    redirect_to new_user_registration_path

  end
  private

  def sign_up_params
    params.require(:user).permit(:username, :registration_id, :email, :contact_no,:password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :registration_id, :email, :password, :password_confirmation)
  end



end