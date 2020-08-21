class NoticesDashboardController < ApplicationController
  rescue_from Exception, :with => :handle_exception
  def mySents
    @notice_obj=NoticeDetail.where("sender_id=(?)",current_user.registration_id)

    @notice_list=[]
    @notice_obj.each do |obj|
      b=Notice.find(obj.notice_id)
      @notice_list.push(b)
    end
  end

  def myUploads
    @notice_obj=NoticeDetail.where("uploader_id=(?)",current_user.registration_id)

    @notice_list=[]
    @notice_obj.each do |obj|
      b=Notice.find(obj.notice_id)
      @notice_list.push(b)
    end
  end

  def myNotices

    @role=current_user.role
    if @role=='student'
      @role=current_user.registration_id
      if @role[3]=='C'
          if @role[1]=='8'
            @role="MCA II"
          elsif @role[1]=='9'
            @role="MCA I"
          elsif @role[1]=='7'
            @role="MCA III"
          end
      elsif @role[3]=='M'
        if @role[1]=='8'
          @role="Mtech II"
        elsif @role[1]=='9'
          @role="MTech I"
        end
      end
    end

    @notice_obj=NoticeDetail.where("sended_to=(?)",@role)

    @notice_list=[]
    @notice_obj.each do |obj|
       b=Notice.find(obj.notice_id)
       @notice_list.push(b)
    end


  end
  def handle_exception(error)

    flash[:error] = "#{error.message}"
    redirect_to notices_dashboard_myNotices_path

  end
  def sam
    require 'date'
    Restricteddate.delete_all
    require 'csv'

    uploaded_io =params[:file] rescue nil
    if uploaded_io!=nil
      File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
        file.write(uploaded_io.read)
      end

      @csv_text = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
      a=CSV.read(@csv_text,headers: true)
      @dataTable = CSV.table(@csv_text)
      name=[]
      date=[]
      a['Name'].each do |x|
        name.append(x)
      end
      a['Date'].each do |x|
        date.append(x)
      end
      i=0
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
      print(a['Name'])
      name.each do |x|
        k = Restricteddate.new
        k.holidayname = x
        k.holidaydate = date[i]
        i+=1
        k.lastupdateddate = Date.today
        k.save
      end
      flash[:error] = " Restricted Dates saved successfully for this year"
      redirect_to notices_path


    else
      flash[:error] = "Choose csv file!"
      redirect_to notice_dashboard_restricted_holiday_list_path
    end



  end


  def restricted_holiday_list


  end

  def update_holiday_list

  end

  def csv
    #require 'date'
    #@cnt=1
    #d = DateTime.now
    #date=d.strftime("%d/%m/%Y")
    #date=date.split('/')
    #dte=date[0]
    #mnth=date[1]
    #year=date[2]
    #
    #details=Leaveapproveddetail.where('extract(month from applied_date) = ?', mnth)
    #month = { 1 => "january", 2 => "febuary", 3 => "march", 4 => "april", 5 => "may", 6 => "june", 7 =>"july", 8 => "august", 9 => "september", 10 => "october", 11 => "november", 12 => "december" }

    #headers = ['column one', 'column two', 'column three']

    #csv_data = CSV.generate(headers: true) do |csv|
    #  csv << headers
      #for x in details
      #csv << [@cnt,x.applicantid,User.find_by_registration_id(x.applicantid).username,x.date_from,x.date_to,x.ltype]
      #@cnt=@cnt+1
      #end

  #  send_data csv_data, filename: "data-#{Date.today.to_s}.csv", disposition: :attachment
  #end
    require 'date'
    @cnt=1
    d = DateTime.now
    date=d.strftime("%d/%m/%Y")
    date=date.split('/')
    dte=date[0]
    mnth=date[1].to_i
    year=date[2]

    if mnth-1==0
      mnth=13

    end
    details=Leaveapproveddetail.where('extract(month from applied_date) = ?', mnth-1)
    headers = ['S.No', 'Applicant ID', 'Applicant Name', 'Date From', 'Date To', 'Leave Type']

    csv_data = CSV.generate(headers: true) do |csv|
      csv << headers
        for x in details
        csv << [@cnt,x.applicantid,User.find_by_registration_id(x.applicantid).username,x.date_from,x.date_to,x.ltype]
        @cnt=@cnt+1
        end
      end
    month = { 1 => "january", 2 => "febuary", 3 => "march", 4 => "april", 5 => "may", 6 => "june", 7 =>"july", 8 => "august", 9 => "september", 10 => "october", 11 => "november", 12 => "december" }
    # print(month[2])
    print(mnth)
    send_data csv_data, filename: "#{month[mnth-1]} leave report.csv", disposition: :attachment
    end
end
