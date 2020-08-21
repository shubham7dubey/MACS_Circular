class NoticesController < ApplicationController
  add_flash_types :info, :error, :warning, :success
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  rescue_from Exception, :with => :handle_exception
  # GET /notices
  # GET /notices.json

  def handle_exception(error)

    flash[:error] = "Error! #{error.message}"
    redirect_to notices_path

  end
  def index
    @notices = Notice.all
    @users = User.all
    @student=User.where("role = 'student'")
    @faculty=User.where("role = 'faculty'")
    @staff=User.where("role = 'staff'")
    custom_group=Group.pluck(:group_name)
    @list=[" ","Faculty","Assistant Lecturers","Staff","All Student","MCA I","MCA II","MCA III","MTech I", "MTech II","Research Scholar"]
    custom_group.each do |name|
      @list.push(name)
    end
    @notice_list=[]
    @notices.each do |notice|
      @notice_list.push(notice.id.to_s+"  -- "+notice.Circular_Title)
    end

    @notice_list1=[]
    @role=current_user.role
    if @role=='student'
      @role=current_user.registration_id
      if @role[3]=='C'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)

        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MCA I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MCA II"
        end


        if ((cy-ayear)==2 and mon>=8 && mon<=12) or  ((cy-ayear)==3 and mon>=1 && mon<8)
          @role="MCA III"
        end
      elsif @role[3]=='M'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)

        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MTech I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MTech II"
        end

      end

      @allStudentObj=NoticeDetail.where("sended_to=(?)","All Student")
      @allStudentObj.each do |student|
        b=Notice.find(student.notice_id)
        @notice_list1.push(b)
      end

    end

    @notice_obj=NoticeDetail.where("sended_to=(?)",@role)


    @notice_obj.each do |obj|
      b=Notice.find(obj.notice_id)
      @notice_list1.push(b)
    end
    @countUnverifiedAccounts=User.where("isVerifiedByAdmin=0")
    @cnt=0
    @userList=[]
    @countUnverifiedAccounts.each do |account|
      @cnt+=1
      @userList.push(account)
    end
   

  end
  def sendcircular
    @notices = Notice.all
    @users = User.all
    @student=User.where("role = 'student'")
    @faculty=User.where("role = 'faculty'")
    @staff=User.where("role = 'staff'")
    custom_group=Group.pluck(:group_name)
    @list=[" ","Faculty","Assistant Lecturers","Staff","All Student","MCA I","MCA II","MCA III","MTech I", "MTech II","Research Scholar"]
    custom_group.each do |name|
      @list.push(name)
    end
    @notice_list=[]
    @notices.each do |notice|
      @notice_list.push(notice.id.to_s+"  -- "+notice.Circular_Title)
    end
    @role=current_user.role
    if @role=='student'
      @role=current_user.registration_id
      if @role[3]=='C'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)


        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MCA I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MCA II"
        end


        if ((cy-ayear)==2 and mon>=8 && mon<=12) or  ((cy-ayear)==3 and mon>=1 && mon<8)
          @role="MCA III"
        end
      elsif @role[3]=='M'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)


        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MTech I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MTech II"
        end

      end
    end

    @notice_obj=NoticeDetail.where("sended_to=(?)",@role)

    @notice_list1=[]
    @notice_obj.each do |obj|
      b=Notice.find(obj.notice_id)
      @notice_list1.push(b)
    end


  end
def send_notice
  @notices = Notice.all
  @users = User.all
  @student=User.where("role = 'student'")
  @faculty=User.where("role = 'faculty'")
  @staff=User.where("role = 'staff'")
  custom_group=Group.pluck(:group_name)
  @list=[" ","Faculty","Assistant Lecturers","Staff","All Student","MCA I","MCA II","MCA III","MTech I", "MTech II","Research Scholar"]
  custom_group.each do |name|
    @list.push(name)
  end
  @notice_list=[]
  @notices.each do |notice|
    @notice_list.push(notice.id )
  end


  @role=current_user.role
  if @role=='student'
    @role=current_user.registration_id
    if @role[3]=='C'
      ayear = Integer(@role[0]+@role[1])
      cy=(Time.current.year)%100
      mon = Integer(Time.now.month)


       if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MCA I"
       end


       if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MCA II"
       end


       if ((cy-ayear)==2 and mon>=8 && mon<=12) or  ((cy-ayear)==3 and mon>=1 && mon<8)
          @role="MCA III"
       end
    elsif @role[3]=='M'
      ayear = Integer(@role[0]+@role[1])
      cy=(Time.current.year)%100
      mon = Integer(Time.now.month)


      if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
        @role="MTech I"
      end


      if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
        @role="MTech II"
      end

    end
  end

  @notice_obj=NoticeDetail.where("sended_to=(?)",@role)

  @notice_list1=[]
  @notice_obj.each do |obj|
    b=Notice.find(obj.notice_id)
    @notice_list1.push(b)
  end

end
  def reg_id
    @id = params[:regid]
    
  end
   

  def notiClick
    @value=User.find(params[:notiClick])
  end

def accept_user
   @v=User.find_by_registration_id(params[:q])
   @v.isVerifiedByAdmin=1
   @v.save

   NotificationMailer.approve_email(@v).deliver_now
   flash[:success] = "Signup request accepted."
   @leave=Leave.new
   @leave.applicantid=@v.registration_id
   @leave.save
   type=params[:q1]
   if type=="notiClick"
     redirect_to notices_path
   elsif type == "allNotice"
     redirect_to notices_all_notices_path
   end
end

  def accept_leave
    require 'date'
    @v=User.find_by_registration_id(params[:q])

    @a=Leaveapprovaldetail.find_by applicantid: params[:q], date_from: params[:s]
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(@a.applicantid)




      @approved=Leaveapproveddetail.new
    @approved.applicantid=@a.applicantid
    @approved.date_to=@a.date_to
    @approved.date_from=@a.date_from
    @approved.applied_date=@a.applied_date
    @approved.ltype=@a.ltype
    @approved.reason=@a.reason
    @approved.address=@a.address
    @approved.administrationduties=@a.administrationduties
    @approved.classarrangement=@a.classarrangement
    @approved.approve_date=Date.today
    @approved.tohalf=@a.tohalf
    @approved.fromhalf=@a.fromhalf

    dateVar = Date.new(@approved.date_to[6..9].to_i,@approved.date_to[0..1].to_i,@approved.date_to[3..4].to_i)
    fromdate = Date.new(@approved.date_from[6..9].to_i,@approved.date_from[0..1].to_i,@approved.date_from[3..4].to_i)
    @daysCount = 0
    i=0

    while fromdate+i <= dateVar do

      a=Date::DAYNAMES[(fromdate+i).wday]
      if not a.eql? "Saturday" and not a.eql? "Sunday"
        @daysCount +=1
      end
      i+=1
    end


    @leavedata=Leave.find_by_applicantid(params[:q])
    print("############################")
    print(@leavedata)
    cl=@leavedata.cl
    ch=@leavedata.ch
    rh=@leavedata.rh
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(@daysCount)
    print(cl)
    if @a.ltype =='CL'
      if @daysCount > cl
        flash[:error] = "Sufficient leaves are not available for the applicant"

      else
        @approved.save
        p=@a.date_from.to_s
        p1=@a.date_to.to_s
        @s= p+" to "+p1
        print(@s)
        @a.delete
        @v.leaveapproval=0
        @v.save

        print("####################################################################sambhav")
        UserMailer.leaveapprove_email(@v,@s).deliver_now
        print('#################################################mail')
        @deductleave=Leave.find_by_applicantid(params[:q])
      @deductleave.cl=@deductleave.cl-@daysCount
      @deductleave.save
      flash[:success] = "Leave request accepted."
      end

    elsif @a.ltype =='CH'
        if @daysCount > ch
          flash[:error] = "Sufficient leaves are not available for the applicant"

        else
          @approved.save
          p=@a.date_from.to_s
          p1=@a.date_to.to_s
          @s= p+" to "+p1
          print(@s)
          @a.delete
          @v.leaveapproval=0
          @v.save

          print("####################################################################sambhav")
          UserMailer.leaveapprove_email(@v,@s).deliver_now
          print('#################################################mail')
          @deductleave=Leave.find_by_applicantid(params[:q])
          @deductleave.ch=@deductleave.ch-@daysCount
          @deductleave.save
          flash[:success] = "Leave request accepted."

        end
    else

      if @daysCount > rh
        flash[:error] = "Sufficient leaves are not available for the applicant"

      else
        @approved.save
        p=@a.date_from.to_s
        p1=@a.date_to.to_s
        @s= p+" to "+p1
        print(@s)
        @a.delete
        @v.leaveapproval=0
        @v.save

        print("####################################################################sambhav")
        UserMailer.leaveapprove_email(@v,@s).deliver_now
        print('#################################################mail')
        @deductleave=Leave.find_by_applicantid(params[:q])
        @deductleave.rh=@deductleave.rh-@daysCount
        @deductleave.save
        flash[:success] = "Leave request accepted."

      end



    end



    redirect_to notices_path

  end

  def decline_user
    @v=User.find_by_registration_id(params[:q])
    NotificationMailer.disapprove_email(@v).deliver_now
    @v.delete
    flash[:error] = "Signup request declined."
    type=params[:q1]
    if type=="notiClick"
      redirect_to notices_path
    elsif type == "allNotice"
      redirect_to notices_all_notices_path
    end
  end

  def decline_leave
    @v=Leaveapprovaldetail.find_by applicantid: params[:q], date_from: params[:s]
    @dreason = params[:dreason]
    @user=User.find_by_registration_id(params[:q])
    @user.leaveapproval=0
    @user.save

    p=@v.date_from.to_s
    p1=@v.date_to.to_s
    @s= p+" to "+p1


    @d=Declinedleavedetail.new
    @d.applicantid=@v.applicantid
    @d.date_to=@v.date_to
    @d.date_from=@v.date_from
    @d.applied_date=@v.applied_date
    @d.rejected_date=Time.new
    @d.reason=@dreason
    @d.save
    @v.delete
    UserMailer.leavedisapprove_email(@user,@dreason,@s).deliver_now
    flash[:error] = "Leave request declined."

      redirect_to notices_path

  end

  def send_id
    s=params[:id]
    UserMailer.id(s)
  end

  def send_email

    usermail=params[:demail]
    userpass=params[:dpass]
    s=params[:mail]
    ids=params[:id]
    #ids=ids.fetch("id")
    ids = ids[0]+ids[1]
    ids = ids.to_i
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(ids)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    @course=params[:branch]
    #@course=b.fetch("id")

    if @course == "MCA I"
        @student=User.where("role = 'student'" ).where("registration_id  like ('194CA%') ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end

     elsif @course == "All Student"
        @student=User.where("role = 'student'" )
        @student.each do |student|
          if student.isVerifiedByAdmin==1
            UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
          end
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end
  

    elsif @course == "MCA II"
        @student=User.where("role = 'student'").where("registration_id  like ('184CA%') " )
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end
    

    elsif @course == "MCA III"
        @student=User.where("role = 'student'").where("registration_id like ('174CA%') " )
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end
    

    elsif @course == "MTech I"
        @student=User.where("role = 'student'").where( "registration_id like  ('194MA%') ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end
    

    elsif @course == "MTech II"
        @student=User.where("role = 'student'").where(  "registration_id like ('184MA%') ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end
    

    elsif @course == "Research Scholar"
        @student=User.where("role = 'Research Scholar'")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
        end
        a=NoticeDetail.where("notice_id= (?)",ids)
        a.each do |record|
          record.sender_id=current_user.registration_id
          record.sended_to=@course
          record.save
        end

    elsif @course == "Assistant Lecturer"
      @student=User.where("role = 'Assistant Lecturer'")
      @student.each do |student|
        UserMailer.circular_email(student,ids,0,usermail,userpass).deliver_now
      end
      a=NoticeDetail.where("notice_id= (?)",ids)
      a.each do |record|
        record.sender_id=current_user.registration_id
        record.sended_to=@course
        record.save
      end
    


    elsif @course == "Faculty"
       @faculty=User.where("role = 'faculty'")
        @faculty.each do |faculty|
          UserMailer.circular_email(faculty,ids,0,usermail,userpass).deliver_now
        end
       a=NoticeDetail.where("notice_id= (?)",ids)
       a.each do |record|
         record.sender_id=current_user.registration_id
         record.sended_to=@course
         record.save
       end
    
        
    elsif @course == "Staff"
       @staff=User.where("role = 'staff'")

        @staff.each do |staff|
          UserMailer.circular_email(staff,ids,0,usermail,userpass).deliver_now
        end
       a=NoticeDetail.where("notice_id= (?)",ids)
       a.each do |record|
         record.sender_id=current_user.registration_id
         record.sended_to=@course
         record.save
       end
    
    elsif s!=""

     @course=s
     a=NoticeDetail.where("notice_id= (?)",ids)
     a.each do |record|
       record.sender_id=current_user.registration_id
       record.sended_to=s
       record.save
     end

     UserMailer.circular_email(s,ids,0,usermail,userpass).deliver_now


    else
      @group_members=GroupDatum.where("group_name_ref= (?)",@course)
      @group_members.each do |group_member_email|

        UserMailer.circular_email(group_member_email,ids,1,usermail,userpass).deliver_now
      end
      a=NoticeDetail.where("notice_id= (?)",ids)
      a.each do |record|
        record.sender_id=current_user.registration_id
        record.sended_to=s
        record.save
      end
    end



    k= SentNoticesDetail.new
    k.sender_id=current_user.registration_id
    k.notices_id=ids
    k.dtime=Time.new
    k.grp_name=@course
    k.save

    flash[:success]="Email sent successfully."
    redirect_to notices_path

    

  end
  
  
    


  # GET /notices/1
  # GET /notices/1.json
  def show


    extension = @notice.Select_File.split('.')




    send_file Rails.root.join('public','uploads',@notice.Select_File), :type => "application/#{extension[1]}", :disposition => 'inline', :x_sendfile =>true

    @file="http://10.11.0.63:3000/notices/".concat(@notice.Select_File,"")



    

  end

  # GET /notices/new
  def new
    @notice = Notice.new
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)
    uploaded_io =params[:notice][:Select_File] rescue nil
    File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
      file.write(uploaded_io.read)
    end
    @notice.Select_File = uploaded_io.original_filename
    respond_to do |format|
      if @notice.save
        format.html { redirect_to notices_path, notice: 'Notice was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
      a=NoticeDetail.new
      a.notice_id=@notice.id
      a.uploader_id=current_user.registration_id
      a.save
    end

    
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    respond_to do |format|
      if @notice.update(notice_params)
        format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
        format.json { render :show, status: :ok, location: @notice }
      else
        format.html { render :edit }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    nid=@notice.id
    obj=NoticeDetail.find_by_notice_id(nid)
    obj.delete
    @notice.destroy

    respond_to do |format|
      format.html { redirect_to notices_url, notice: 'Notice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(:Circular_Title, :Select_File)
    end


  def all_notices
    @notices = Notice.all
    @users = User.all
    @student=User.where("role = 'student'")
    @faculty=User.where("role = 'faculty'")
    @staff=User.where("role = 'staff'")
    custom_group=Group.pluck(:group_name)
    @list=[" ","Faculty","Assistant Lecturers","Staff","All Student","MCA I","MCA II","MCA III","MTech I", "MTech II","Research Scholar"]
    custom_group.each do |name|
      @list.push(name)
    end
    @notice_list=[]
    @notices.each do |notice|
      @notice_list.push(notice.id)
    end

    @notice_list1=[]
    @role=current_user.role
    if @role=='student'
      @role=current_user.registration_id
      if @role[3]=='C'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)

        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MCA I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MCA II"
        end


        if ((cy-ayear)==2 and mon>=8 && mon<=12) or  ((cy-ayear)==3 and mon>=1 && mon<8)
          @role="MCA III"
        end
      elsif @role[3]=='M'
        ayear = Integer(@role[0]+@role[1])
        cy=(Time.current.year)%100
        mon = Integer(Time.now.month)

        if ((cy-ayear)==0 and mon>=8 && mon<=12) or  ((cy-ayear)==1 and mon>=1 && mon<8)
          @role="MTech I"
        end


        if ((cy-ayear)==1 and mon>=8 && mon<=12) or  ((cy-ayear)==2 and mon>=1 && mon<8)
          @role="MTech II"
        end

      end

      @allStudentObj=NoticeDetail.where("sended_to=(?)","All Student")
      @allStudentObj.each do |student|
        b=Notice.find(student.notice_id)
        @notice_list1.push(b)
      end

    end

    @notice_obj=NoticeDetail.where("sended_to=(?)",@role)


    @notice_obj.each do |obj|
      b=Notice.find(obj.notice_id)
      @notice_list1.push(b)
    end
    @countUnverifiedAccounts=User.where("isVerifiedByAdmin=0")
    @cnt=0
    @userList=[]
    @countUnverifiedAccounts.each do |account|
      @cnt+=1
      @userList.push(account)
    end


  end





 


end