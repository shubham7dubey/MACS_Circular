class PagesController < ApplicationController
  rescue_from Exception, :with => :handle_exception

  def handle_exception(error)

    flash[:error] = "#{error.message}"
    redirect_to root_path

  end
  def home
  	@name=params[:user]
  	@pass=params[:password]

  	

  end
  def login
  	@name=params[:user]
  	@pass=params[:password]
  end

  def contact
    require 'csv'

    @csv_text = Rails.root.join('public', 'uploads', 'contacts.csv')
    a=CSV.read(@csv_text,headers: true)
    @dataTable = CSV.table(@csv_text)
    a["E-mail 1 - Value"].each do |u|
      print(u)
      print("\n")
    end



  end




end
