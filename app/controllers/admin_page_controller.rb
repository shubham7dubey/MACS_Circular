class AdminPageController < ApplicationController
  add_flash_types :info, :error, :warning, :success

  rescue_from Exception, :with => :handle_exception

  def handle_exception(error)

    flash[:error] = "#{error.message}"
    redirect_to admin_page_new_path

  end
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

  def make_incharge
    require 'date'
    a=Inchargedetail.new
    a.inchargeid = params[:id].split()[0]
    datet = params[:datepickerto]
    a.dateto = Date.new(datet[6..9].to_i,datet[0..1].to_i,datet[3..4].to_i)
    datef = params[:datepickerfrom]
    a.datefrom = Date.new(datef[6..9].to_i,datef[0..1].to_i,datef[3..4].to_i)
    a.save
    flash[:info] = "You Appointed " + params[:id].split()[0] + " as incharge from " + params[:datepickerfrom] + " to " + params[:datepickerto]
    redirect_to notices_path
  end

  def addch
   facid=params[:id].split()[0]
   print(facid)
    cnt=params[:days]
    a=Leave.find_by_applicantid(facid)
    a.ch= a.ch.to_i + cnt.to_i
    a.save
   flash[:success] = "CH added successfully"
   redirect_to notices_path
  end

  def dynamiccancelLeave
    require 'date'
    @tdate = Date.today

    @dfrom = params[:q1]
    @dto = params[:q2]
    @dfrom = Date.new(@dfrom[6..9].to_i,@dfrom[0..1].to_i,@dfrom[3..4].to_i)
    @dto = Date.new(@dto[6..9].to_i,@dto[0..1].to_i,@dto[3..4].to_i)
    @data=Dynamicleavecancel.find_by applicantid: params[:q0], date_from: params[:q1]
    v = @data.created_at.to_s
    @data.delete

    v = Date.new(v[0..3].to_i,v[5..6].to_i,v[8..9].to_i)
    if v >= @dfrom and v < @dto

      @daysCount = 0
      i=0
      while v+i <= @dto do
        a=Date::DAYNAMES[(v+i).wday]
        if not a.eql? "Saturday" and not a.eql? "Sunday"
          @daysCount +=1
        end
        i+=1
      end

      @temp = @daysCount


      @leave = Leave.find_by_applicantid(params[:q0])
      @approvedLeave = Leaveapproveddetail.find_by applicantid: params[:q0], date_from: params[:q1]
      @approvedLeave.date_to = v-1
      @approvedLeave.save
      @ltype = @approvedLeave.ltype
      if @ltype == 'CL'
        @leave.cl = @leave.cl + @temp
        @leave.save
      elsif @ltype == 'CH'
        @leave.ch = @leave.ch + @temp
        @leave.save
      elsif @ltype == 'RH'
        @leave.rh = @leave.rh + 1
        @leave.save
      end
    else
      @approvedLeave = Leaveapproveddetail.find_by applicantid: params[:q0], date_from: params[:q1]
      @approvedLeave.delete
      @leave = Leave.find_by_applicantid(params[:q0])
      @ltype = @approvedLeave.ltype
      @temp  = @dto - @dfrom + 1
      if @ltype == 'CL'
        @leave.cl = @leave.cl + @temp
        @leave.save
      elsif @ltype == 'CH'
        @leave.ch = @leave.ch + @temp
        @leave.save
      elsif @ltype == 'RH'
        @leave.rh = @leave.rh + 1
        @leave.save
      end
    end
    @user= User.find_by_registration_id(params[:q0])
    UserMailer.leavecancel(@user).deliver_now
    flash[:error] = "Leave Cancelled."
    redirect_to notices_path
  end

end
