class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
    #redirect_to '/liveQuestions'
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    stats = nil
    if params[:id]
      @user = User.find(params[:id])
      stats = statistics(@user)
    elsif session[:id]
        @user = User.find(session[:id])
        stats = statistics(@user)
    else
      flash[:error] = "Please Login and Try again!"
      redirect_to '/login'
    end

    if stats.instance_of? Array
       @number_of_posts = stats.length
    else
       @null_message = stats
    end

    # respond_to do |format|
     #   format.html # show.html.erb
      #  format.xml  { render :xml => @user }
      #  end

  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to('/login', :notice => 'Success! User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    # If we delete a user; we need to delete all his posts and votes to that post.
    @votes = Vote.find_all_by_users_id(params[:id])
    if !@votes.nil?
      @votes.each do |v|
        logger.info v.id
        post = Post.find_by_id(v.posts_id)
        post.num_of_votes = post.num_of_votes - 1
        post.save
        v.destroy
      end
    end

    # If we are deleting a POST we are required to delete all the votes related to that POST.
    @posts = Post.find_all_by_users_id(params[:id])
    if !@posts.nil?
        @posts.each do |p|
        logger.info p.id
        delete_votes(p.id)
        delete_reply(p.id)
        p.destroy
      end
    end

    redirect_to '/liveQuestions'
  end

  def statistics(user)
    posts = Post.find_all_by_users_id(user.id)
    if posts.nil?
      "No Posts by this User."
    else
      posts
    end
  end

    def delete_votes(post_id)
    vote = Vote.find_all_by_posts_id(post_id)
    if !vote.nil?
        vote.each do |v|
          v.destroy
        end
     end
  end

  def delete_reply(post_id)
    reply = Post.find_all_by_parent(post_id)
    if !reply.nil?
       reply.each do  |r|
         delete_votes(r.id)
         r.destroy
       end
    end
  end



end
