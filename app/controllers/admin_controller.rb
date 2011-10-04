class AdminController < ApplicationController
  def new
  @user = User.new
     puts "admin new"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
     @user = User.new(params[:user])
     puts "admin create"
    respond_to do |format|
      if @user.save
        format.html { redirect_to('/liveQuestions', :notice => 'Success! Admin was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
