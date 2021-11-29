class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy]
  before_action :post_params, only: %i[create update]

  def index
    @posts = current_user.post.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new; end

  def create
    return unless Post.new(post_params.merge({ user_id: current_user.id })).save!

    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    return unless Post.where(id: params[:id]).first.update(post_params)

    redirect_to posts_path
  end

  def destroy
    return unless Post.where(id: params[:id]).first.destroy

    redirect_to posts_path
  end

  def create_comment
    return unless build_comment

    redirect_to action: 'show', id: params[:post_id]
  end

  private

  def build_comment
    comment = Post.where(id: params[:post_id]).first.comment
    comment.new(body: params[:body], user_id: correct_user.id).save!
  end

  def correct_user
    current_user.nil? ? User.where(username: 'Anonymous/Anonimo').first : current_user
  end

  def post_params
    {
      title: params[:title],
      body: params[:body]
    }
  end
end
