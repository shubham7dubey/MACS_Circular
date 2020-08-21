class NotificationMailer < ApplicationMailer
  default from: 'testmacs7@gmail.com'

  def approve_email(user)
      @user=user
      mail(to: @user.email, subject: "Your request have been succesfully approved")
    end


    def disapprove_email(user)
      @user=user
      mail(to: @user.email, subject: "Your request have been Rejected")
    end

    def leaveapprove_email(user)
    @user=user
    mail(to: @user.email, subject: "Your Leave request have been Accepted")
    end

    def leavedisapprove_email(user)
    @user=user
    mail(to: @user.email, subject: "Your Leave request have been Rejected")
    end


end
