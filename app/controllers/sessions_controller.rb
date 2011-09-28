class SessionsController < ApplicationController
  def new
    @title = "Login to LiveQuestionTool"
  end

  def create
    check_user =  User.check_password(params[:session][:username],params[:session][:password])
    if check_user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
        session[:username] = check_user.username
        session[:id] = check_user.id
        @result = "Success"
        #sign_in user
        #redirect_to  '/signup' ## Add route here to the appropriate page which uses session variables.
    end
  end

  def destroy
    reset_session
    redirect_to signup_path
  end

end
