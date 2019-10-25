class UserMailer < ApplicationMailer
	default from: 'siddharth.jmanit@gmail.com'
	
	def circular_email(user,id,isCustom)
		@user = user
		@id = id
		if isCustom==0
			if user.class==String
				mail(to: @user, subject: 'This is new circular')
			else	
				mail(to: @user.email, subject: 'This is new circular')
			end
		else
			if user.class==String
				mail(to: @user, subject: 'This is new circular')
			else	
				mail(to: @user.cg_email, subject: 'This is new circular')
			end

		end
	end
	
	def id

	end


end
