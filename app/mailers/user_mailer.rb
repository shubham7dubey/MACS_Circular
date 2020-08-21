class UserMailer < ApplicationMailer
	default from: 'testmacs7gmail.com'
	def circular_email(user,id,isCustom,usermail,userpass)

		delivery_options = { user_name: usermail,
												 password: userpass,
												 address: 'smtp.gmail.com' }


		@user = user
		@id = id
		a=Notice.find(@id)
		@em_at = Rails.root.join('public', 'uploads', a.Select_File)
		attachments.inline['NewCircular.pdf'] = File.read(@em_at)
		if isCustom==0
			if user.class==String
				mail(to: @user, subject: 'New circular from MACS',
						 delivery_method_options: delivery_options)
			else	
				mail(to: @user.email, subject: 'New circular from MACS',
						 delivery_method_options: delivery_options)
			end
		else
			if user.class==String
				mail(to: @user, subject: 'New circular from MACS',
						 delivery_method_options: delivery_options)
			else	
				mail(to: @user.cg_email, subject: 'New circular from MACS',
						 delivery_method_options: delivery_options)
			end

		end
		print("*****************************************************************************")
		
	end
	


	def leaveapprove_email(user,date)
		@user=user
		@date=date
		mail(to: @user.email, subject: "Your Leave request have been Accepted")
	end

	def leavedisapprove_email(user,reason,date)
    @dreason=reason
		@user=user
		@date=date
		mail(to: @user.email, subject: "Your Leave request have been Rejected")
	end

	def leavecancel(user)
		@user=user
		mail(to: @user.email, subject: "Your Leave has been cancelled")
	end


end
