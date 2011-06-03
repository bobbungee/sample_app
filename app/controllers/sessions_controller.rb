class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    
    if user.nil?
      if User.find_by_email(params[:session][:email]).nil?
        flash.now[:error] = "Email is invalid (does not exist)"
      else
        flash.now[:error] = "Invalid email/password combination"
      end
      
      @title = "Sign in"
      render 'new'
    else
      # Sign the user in and redirect to the user's show page
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
