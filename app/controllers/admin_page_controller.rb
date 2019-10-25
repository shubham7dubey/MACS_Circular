class AdminPageController < ApplicationController
  def new
  	@id=params[:regid]

  	
  	



  end

  def create
  	@id=params[:reg]
  	@role =params[:role]
  	@regi = params[:reg]
  	@regi_prev =params[:reg]
  	@email = params[:email]
  	@user = params[:user]
  end

  def save
  	
  	@regid =params[:reg]
    @a=User.find_by_registration_id(@regid)
    @a.role=params[:role]
    @a.registration_id = params[:reg]
    @a.email =params[:email]
    @a.username =params[:user]
    @a.save
    redirect_to admin_page_new_path


  end

  
   def sent_history
    @data=SentNoticesDetail.all
   end

end
