class ArticlesController < ApplicationController
  before_action :correct_user

  def index
      @user = User.find(params[:user_id])
      @articles = if params[:term]
       @user.articles.includes(:tags).where("articles.task LIKE :search OR tags.name LIKE :search", search: "%#{params[:term]}%" ).references(:tags)
        else
       @user.articles.all
  end
end
#    if params[:tag]
 #     @articles =  @user.articles.tagged_with(params[:tag])
 #   else
 #     @articles =  @user.articles.all
 #   end


	def show
        @user = User.find(params[:user_id])
    @article = @user.articles.find(params[:id])
  end
 def new
      @user = User.find(params[:user_id])
  @article = @user.articles.new
end

def edit
      @user = User.find(params[:user_id])
  @article = @user.articles.find(params[:id])
end
 
def create
  @user = User.find(params[:user_id])
  @article = @user.articles.new(article_params)
 
  if @article.save
    redirect_to user_articles_url
  else
    render 'new'
  end
end

def update
   @user = User.find(params[:user_id])
  @article = @user.articles.find(params[:id])
 
  if @article.update(article_params)
    redirect_to user_articles_path
  else
    render 'edit'
  end
end

def destroy
  @user = User.find(params[:user_id])
  @article = @user.articles.find(params[:id])
  @article.destroy
 
  redirect_to user_articles_path
end
private
  def article_params
    params.require(:article).permit(:task, :deadline, :tag_list, :term)
  end


    # Confirms a logged_in user_
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
end