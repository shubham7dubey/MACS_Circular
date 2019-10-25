class PagesController < ApplicationController
  def home
  	@name=params[:user]
  	@pass=params[:password]

  	

  end
  def login
  	@name=params[:user]
  	@pass=params[:password]
  end
end
