class PostsController < ApplicationController
 before_action :find_post, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!, except: [:index, :show]
 def index
   @posts = Post.all.order("created_at DESC")
  end
 def new
  @post = current_user.posts.build
 end

 def create
   @post = current_user.posts.build(post_params)
 if @post.save
    redirect_to @post
   else
    render 'new'
   end
  end

  def show
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
   end
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  if @comment.update(params[:comment].permit(:comment))
     redirect_to post_path(@post)
    else
     render 'edit'
    end
   end

  def destroy
    @post.destroy
    redirect_to root_path
   end

private

def find_post
  @post = Post.find(params[:id])
 end

 def post_params
  params.require(:post).permit(:title, :content)
 end
end
