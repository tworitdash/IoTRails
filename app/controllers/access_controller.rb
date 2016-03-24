class AccessController < ApplicationController
  
  layout 'admin'
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout, :register]

  def index
  	menu 
  	render('menu')
  end
  def menu
  end

  def login

  end
  def register
  	#@user = User.new
  	@user = User.new(params[:user])
  	
    if @user.save
      flash[:notice] = "You signed up successfully. Log into your application."
      flash[:color]= "valid"
      redirect_to(:action =>'login');
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
  end
  def attempt_login
  	authorized_user = User.authenticate(params[:username], params[:password])
  	if authorized_user
  		session[:user_id] = authorized_user.id 
  		session[:username] = authorized_user.username
  		flash[:notice] = "You are successfully logged in !"
  		redirect_to(:controller => 'tweet', :action => 'list')
  	else 
  		flash[:notice] = "Invalid User"
  		redirect_to(:action => 'login')
  	end
  end
  def logout 
  	session[:user_id] = nil
  	session[:username] = nil
  	flash[:notice] = "You have been logged out."
  	redirect_to(:action => 'login')
  end
end
