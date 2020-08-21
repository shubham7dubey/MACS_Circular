class GroupController < ApplicationController
  add_flash_types :info, :error, :warning, :success

  rescue_from Exception, :with => :handle_exception
  def group_home
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
  def handle_exception(error)

    flash[:error] = "#{error.message}"
    redirect_to group_group_home_path

  end
def create_group_function
    a=params[:fields]
    if a
      grp_name=params[:g_name]
      b=Group.new
      if grp_name.length!=0
        b.group_name=grp_name
        b.created_by=current_user.role
        b.save
        a= a[0].split(',')

        for x in a
           k=GroupDatum.new
           k.group_name_ref=grp_name
           temp = x.strip()
           if !temp.blank?
            k.cg_email= temp
            k.save
           end


           @f=1
          end

        flash[:success] = "Group created successfully."
        redirect_to notices_path
      end
    else
      flash[:error] = "Group must contain atleast two members."
      redirect_to group_group_home_path
    end
end
  def group_delete
    @custom_group=Group.where("created_by= (?)",current_user.role).pluck(:group_name)
    @list=[]

    @custom_group.each do |name|

      @list.push(name)
    end

    

  end

 def delete_group_btn
   @course=params[:group]
    #@course=b.fetch("id")
  #print(@course)
    Group.where(group_name: @course).destroy_all
    GroupDatum.where(group_name_ref: @course).destroy_all
    flash[:success] = "Group deleted successfully."
    redirect_to group_groupDetails_path
 end



  def create_from_csv
    require 'csv'

    uploaded_io =params[:file] rescue nil
    if uploaded_io!=nil
      File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
        file.write(uploaded_io.read)
      end

      @csv_text = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
      a=CSV.read(@csv_text,headers: true)
      @dataTable = CSV.table(@csv_text)
      print(a["E-mail 1 - Value"])
      nameg=params[:gc_name]
      grp_name=params[:gc_name]
      b=Group.new
      if grp_name.length!=0
        b.group_name=grp_name
        b.created_by=current_user.role
        print(grp_name)
        b.save

        i=0
        a["E-mail 1 - Value"].each do |x|
          k=GroupDatum.new
          k.group_name_ref=grp_name
          k.cg_email=x
          k.save
          @f=1
        end

        flash[:success] = "Group Created successfully."
        redirect_to notices_path

      end
    else
      flash[:error] = "Choose csv file!"
      redirect_to group_group_home_path
    end

  end

  def groupDetails
    @group=Group.where("created_by = (?)",current_user.role)


  end

  def group_details_show
    @grp=params[:group]
    print("===============================")
    print(@grp)

  end

  def group_table
    @name=params[:groupName]
    print("===============================")
    print(@name)

  end

  def group_edit

  end





end
