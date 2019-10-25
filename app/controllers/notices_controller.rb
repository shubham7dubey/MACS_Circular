class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all
    @users = User.all
    @student=User.where("role = 'student'")
    @faculty=User.where("role = 'faculty'")
    @staff=User.where("role = 'staff'")
    custom_group=Group.pluck(:group_name)
    @list=[" ","Faculty","Staff","All Student","MCA I","MCA II","MCA III","MTech I", "MTech II","PHd"]
    custom_group.each do |name|
      @list.push(name)
    end
    

    
    


    
  end

  def reg_id
    @id = params[:regid]
    
  end
   

  

  def send_id
    s=params[:id]
    UserMailer.id(s)
  end

  def send_email

    s=params[:mail]
    ids=params[:id]
    b=params[:branch]
    @course=b.fetch("id")

    if @course == "MCA I"
        @student=User.where("role = 'student'" ).where("registration_id like '194CA%' ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    

     elsif @course == "All Student"
        @student=User.where("role = 'student'" )
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
  

    elsif @course == "MCA II"
        @student=User.where("role = 'student'").where("registration_id like '184CA%' " )
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    

    elsif @course == "MCA III"
        @student=User.where("role = 'student'").where("registration_id like '174CA%' " )
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    

    elsif @course == "MTech I"
        @student=User.where("role = 'student'").where( "registration_id like '192MA%' ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    

    elsif @course == "MTech II"
        @student=User.where("role = 'student'").where(  "registration_id like '182MA%' ")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    

    elsif @course == "PHd"
        @student=User.where("role = 'student'")
        @student.each do |student|
          UserMailer.circular_email(student,ids,0).deliver_now
        end
    


    elsif @course == "Faculty"
       @faculty=User.where("role = 'faculty'")
        @faculty.each do |faculty|
          UserMailer.circular_email(faculty,ids,0).deliver_now
        end
    
        
    elsif @course == "Staff"
       @staff=User.where("role = 'staff'")

        @staff.each do |staff|
          UserMailer.circular_email(staff,ids,0).deliver_now
        end
    
    elsif s!=""
      
     @course=s
      UserMailer.circular_email(s,ids,0).deliver_now
    end

    else
      @group_members=GroupDatum.where("group_name_ref= (?)",@course)
      @group_members.each do |group_member_email|
        UserMailer.circular_email(group_member_email,ids,1).deliver_now
        end    


    k= SentNoticesDetail.new
    k.sender_id=current_user.registration_id
    k.notices_id=ids
    k.dtime=Time.new
    k.grp_name=@course
    k.save
  
    redirect_to notices_path
    

  end
  
  
    


  # GET /notices/1
  # GET /notices/1.json
  def show


    extension = @notice.Select_File.split('.')
    send_file Rails.root.join('public','uploads',@notice.Select_File),
    :type => "application/#{extension[1]}", :x_sendfile =>true
   
    @file="http://localhost:3000/notices/".concat(@notice.Select_File)



    

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
end
