class LeaveFormsController < ApplicationController
  rescue_from Exception, :with => :handle_exception



  def handle_exception(error)

    flash[:error] = "Error! #{error.message}"
    redirect_to notices_path

  end
  def cl_form

  end

  def pl_form
  end


  def previewbtn
    require 'date'

    @ltype=params[:ltype]
    @ptype=params[:pleave]
    @address=params[:address]
    @dfrom=params[:datepickerfrom]
    @dto=params[:datepickerto]
    @tohalf=params[:tohalf]
    @fromhalf=params[:fromhalf]
    @alter=params[:alternate]
    @rd1=params[:arrange]
    @alternativeclass= @rd1
    if @rd1  != "No Classes"
      @clsalter = params[:two]
      @alternativeclass += ":-  "
      @alternativeclass += @clsalter
    end

    @admnsalter = params[:admns]

    if @clsater == nil
      @clsalter=""
    end

    if current_user.role !='hod'
    d=Leaveapprovaldetail.new

    d.applicantid=current_user.registration_id


    #print("###############")
    #print(@dto)
    d.date_from=@dfrom
    @s = @dto
    dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
    fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @daysCount = 0
    i=0
    d.date_to = @s
    while fromdate+i <= dateVar do

      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end
    @leavedata=Leave.find_by_applicantid(current_user.registration_id)
    cl=@leavedata.cl
    if @daysCount > cl
      flash[:error] = "Sufficient leave are not available"
      redirect_to notices_path

    else



    print("###################################")

    print("###################################")
    a=current_user.registration_id
    @user = User.find_by_registration_id(a)

    @user.leaveapproval = @daysCount
    @user.save



    d.applied_date=Time.new
    d.ltype=@ltype
    d.reason=@ptype
    d.address=@address
    d.administrationduties=@admnsalter
    k=@rd1.to_s + @clsalter.to_s
    d.classarrangement=@alternativeclass
    d.tohalf=@tohalf
    d.fromhalf=@fromhalf
    d.save
    print("#################################################")

    flash[:error] = "Leave Application Submitted"

    date = Time.new


    date = date.day.to_s  + date.month.to_s  + date.year.to_s

       pdf = WickedPdf.new.pdf_from_string(
         render_to_string('previewbtn', layout: false))
        send_data(pdf,
         filename: @ltype+date+'.pdf',
        type: 'application/pdf',
       disposition: 'attachment',
       )


    end
    else
      date = Time.new


      date = date.day.to_s  + date.month.to_s  + date.year.to_s
      pdf = WickedPdf.new.pdf_from_string(
          render_to_string('previewbtn', layout: false))
      send_data(pdf,
                filename: @ltype+date+'.pdf',
                type: 'application/pdf',
                disposition: 'attachment',
                )

    end
  end


  def chpreviewbtn
    require 'date'

    @ltype=params[:ltype]
    @ptype=params[:pleave]
    @address=params[:address]
    @dfrom=params[:datepickerfrom]
    @dto=params[:datepickerto]
    @tohalf=params[:tohalf]
    @fromhalf=params[:fromhalf]
    @alter=params[:alternate]
    @rd1=params[:arrange]
    @alternativeclass= @rd1
    if @rd1  != "No Classes"
      @clsalter = params[:two]
      @alternativeclass += ":-  "
      @alternativeclass += @clsalter
    end
    @admnsalter = params[:admns]

    if @clsater == nil
      @clsalter=""
    end
    if current_user.role!="hod"
    d=Leaveapprovaldetail.new

    d.applicantid=current_user.registration_id
    d.date_from=@dfrom
    @s = @dto
    dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
    fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @daysCount = 0
    i=0
    d.date_to = @s
    while fromdate+i <= dateVar do
      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end


    @leavedata=Leave.find_by_applicantid(current_user.registration_id)
    ch=@leavedata.ch
    if @daysCount > ch
      flash[:error] = "Sufficient leave are not available"
      redirect_to notices_path

    else
    print("###################################")

    print("###################################")
    a=current_user.registration_id
    @user = User.find_by_registration_id(a)

    @user.leaveapproval = @daysCount
    @user.save



    d.applied_date=Time.new
    d.ltype=@ltype
    d.reason=@ptype
    d.address=@address
    d.administrationduties=@admnsalter
    k=@rd1.to_s + @clsalter.to_s
    d.classarrangement=@alternativeclass
    d.tohalf=@tohalf
    d.fromhalf=@fromhalf
    d.save
    print("#################################################")

    flash[:error] = "Leave Application Submitted"

    date = Time.new


    date = date.day.to_s  + date.month.to_s  + date.year.to_s

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string('previewbtn', layout: false))
    send_data(pdf,
              filename: @ltype+date+'.pdf',
              type: 'application/pdf',
              disposition: 'attachment',
              )

    end
    else
      date = Time.new


      date = date.day.to_s  + date.month.to_s  + date.year.to_s

      pdf = WickedPdf.new.pdf_from_string(
          render_to_string('previewbtn', layout: false))
      send_data(pdf,
                filename: @ltype+date+'.pdf',
                type: 'application/pdf',
                disposition: 'attachment',
                )
end

  end



def rhpreviewbtn
  require 'date'

  @ltype=params[:ltype]
  @ptype=params[:pleave]
  @address=params[:address]
  @dfrom=params[:datepickerto]
  @dto=params[:datepickerto]
  @tohalf=params[:tohalf]
  @fromhalf=params[:fromhalf]
  @alter=params[:alternate]
  @rd1=params[:arrange]
  @alternativeclass= @rd1
  if @rd1  != "No Classes"
    @clsalter = params[:two]
    @alternativeclass += ":-  "
    @alternativeclass += @clsalter
  end
  @admnsalter = params[:admns]

  if @clsater == nil
    @clsalter=""
  end
  if current_user.role!="hod"
  d=Leaveapprovaldetail.new

  d.applicantid=current_user.registration_id
  d.date_from=@dfrom
  @s = @dto
  dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
  fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
  @daysCount = 0
  i=0
  d.date_to = @s
  while fromdate+i <= dateVar do
    a=Date::DAYNAMES[(fromdate+i).wday]
    if not a.eql? "Saturday" and not a.eql? "Sunday"
      @daysCount +=1
    end
    i+=1
  end

  @leavedata=Leave.find_by_applicantid(current_user.registration_id)
  ch=@leavedata.ch
  if @daysCount > ch
    flash[:error] = "Sufficient leave are not available"
    redirect_to notices_path

  else
  print("###################################")

  print("###################################")
  a=current_user.registration_id
  @user = User.find_by_registration_id(a)

  @user.leaveapproval = @daysCount
  @user.save



  d.applied_date=Time.new
  d.ltype=@ltype
  d.reason=@ptype
  d.address=@address
  d.administrationduties=@admnsalter
  k=@rd1.to_s + @clsalter.to_s
  d.classarrangement=@alternativeclass
  d.tohalf=@tohalf
  d.fromhalf=@fromhalf
  d.save
  print("#################################################")

  flash[:error] = "Leave Application Submitted"

  date = Time.new


  date = date.day.to_s  + date.month.to_s  + date.year.to_s

  pdf = WickedPdf.new.pdf_from_string(
      render_to_string('previewbtn', layout: false))
  send_data(pdf,
            filename: @ltype+date+'.pdf',
            type: 'application/pdf',
            disposition: 'attachment',
            )
  end
  else
    date = Time.new


    date = date.day.to_s  + date.month.to_s  + date.year.to_s

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string('previewbtn', layout: false))
    send_data(pdf,
              filename: @ltype+date+'.pdf',
              type: 'application/pdf',
              disposition: 'attachment',
              )
    end

end

  def showleaveform
    require 'date'
    @data=Leaveapprovaldetail.find_by applicantid: params[:q], date_from: params[:s]
    print("##########################################")
    print(@data.ltype)
    @user=User.find_by_registration_id(params[:q])

    @ltype=@data.ltype
    @ptype=@data.reason
    @address=@data.address
    @dfrom=@data.date_from
    @dto=@data.date_to
    @tohalf=@data.tohalf
    @fromhalf=@data.fromhalf
    @alter=@data.classarrangement


    @admnsalter =@data.administrationduties
    @s = @dto
    dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
    fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @daysCount = 0
    i=0
    while fromdate+i <= dateVar do

      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end


    respond_to do |format|
      format.html
      format.pdf do
        render template: 'leave_forms/showleaveform.html.erb', pdf: 'sambhav',target: '_blank'

      end
    end
  end

  def showleaveformcancel
    require 'date'
    @data=Leaveapproveddetail.find_by applicantid: params[:q], date_from: params[:s]
    print("##########################################")
    print(@data.ltype)
    @user=User.find_by_registration_id(params[:q])

    @ltype=@data.ltype
    @ptype=@data.reason
    @address=@data.address
    @dfrom=@data.date_from
    @dto=@data.date_to
    @tohalf=@data.tohalf
    @fromhalf=@data.fromhalf
    @alter=@data.classarrangement


    @admnsalter =@data.administrationduties
    @s = @dto
    dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
    fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @daysCount = 0
    i=0
    while fromdate+i <= dateVar do

      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end


    respond_to do |format|
      format.html
      format.pdf do
        render template: 'leave_forms/showleaveform.html.erb', pdf: 'sambhav',target: '_blank', disposition: 'inline'

      end
    end
  end

  def leaves_stats
    @leave=Leave.find_by_applicantid(current_user.registration_id)

  end
  def pl_leave

    require 'date'
    @ltype=params[:ltype]
    @ptype=params[:pleave]
    @address=params[:address]
    @dfrom=params[:datepickerfrom]
    @dto=params[:datepickerto]
    @tohalf=params[:tohalf]
    @fromhalf=params[:fromhalf]
    @alter=params[:alternate]
    @rd1=params[:arrange]
    @alternativeclass= @rd1
    if @rd1  != "No Classes"
      @clsalter = params[:two]
      @alternativeclass += ":-  "
      @alternativeclass += @clsalter
    end





    @s = @dto
    dateVar = Date.new(@s[6..9].to_i,@s[0..1].to_i,@s[3..4].to_i)
    fromdate = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @daysCount = 0
    i=0

    while fromdate+i <= dateVar do

      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end

    @admnsalter = params[:admns]

    if @clsater == nil
      @clsalter=""
    end

    date = Time.new
    date = date.day.to_s  + date.month.to_s  + date.year.to_s
    pdf = WickedPdf.new.pdf_from_string(
        render_to_string('previewbtn', layout: false))
    send_data(pdf,
              filename: @ltype+date+'.pdf',
              type: 'application/pdf',
              disposition: 'attachment',
              )



  end

  def cancelLeave
    @a =  Dynamicleavecancel.new
    @a.applicantid = current_user.registration_id
    @a.date_from = params[:q1]
    @a.date_to = params[:q2]
    @a.save
    flash[:error] = "Applied for Leave Cancellation"
    redirect_to notices_path
  end
    end
