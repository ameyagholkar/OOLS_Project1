class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    redirect_to '/liveQuestions'
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    reply = Post.find_all_by_parent(params[:id])
    if !reply.nil?
       reply.each do  |r|
         delete_votes(r.id)
         r.destroy
       end
    end

    @post = Post.find(params[:id])
    delete_votes(@post.id)
    @post.destroy

    logger.info "In the destroy method."
    respond_to do |format|
      format.html { redirect_to('/liveQuestions') }
      format.xml  { head :ok }
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

end
