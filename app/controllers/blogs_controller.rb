class BlogsController < ApplicationController
  
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :list]
  before_action :require_login
  
  def index
    @blogs = Blog.all
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      
       @user = current_user
       ContactMailer.contact_mail(@user).deliver
       
       redirect_to blogs_path, notice: "Crerated Post"
       
    else
       render 'new'
    end
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def edit
  end
  
  def top
  end
  
  def update
    if @blog.update(blog_params)
       redirect_to blogs_path, notice: "Up To Date"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"Erased"
  end

  private
  
  def require_login
    unless logged_in?
      flash[:notice] = 'Log in'
      redirect_to new_session_path
    end
  end  
  
  def blog_params
    params.require(:blog).permit(:content, :user_id, :image, :image_cache)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
end
