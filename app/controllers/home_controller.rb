class HomeController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page], per_page: 3).order('created_at ASC')
  end
end
