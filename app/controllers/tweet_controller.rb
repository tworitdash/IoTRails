class TweetController < ApplicationController
	layout 'admin'
	before_filter :confirm_logged_in 

	def new 
		@tweet = Tweet.new(:user_id => session[:user_id])
	end
	def show
		@user = User.find(session[:user_id])
		@tweet = Tweet.find(params[:id])
		#@user = User.find(session[:user_id])
		#respond_to do |format|
			#format.html
			#format.xml {render :xml => @tweet}
			#format.json {render :json => @tweet}
		#end
	end
	def list
		@user = User.find(session[:user_id])
		@tweet = @user.tweets
		#@tweet = Tweet.find_by_user_id(session[:user_id])
	end
	def create
		@tweet = Tweet.new(status_params)
		@user = User.find(session[:user_id])
		if @tweet.valid?
			if @tweet.save
				@user.tweets << @tweet
				flash[:notice] = "Your tweet has been published and saved."
				redirect_to(:action => 'list')
			else 
				flash[:notice] = "#{@tweet.errors.full_messages}"
			end
		else 
			flash[:notice] = "#{@tweet.errors.full_messages}"
			redirect_to(:action => 'new')
		end
	end
	def delete
		@tweet = Tweet.find(params[:id])
	end
	def destroy
		Tweet.find(params[:id]).destroy
    	flash[:notice] = "Tweet Deleted"
    	redirect_to(:action => 'list')
    end
   private 

    def status_params
    	params.require(:status).permit(:tweet, :created_at)
  	end

end
