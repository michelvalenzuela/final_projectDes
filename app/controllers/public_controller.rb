class PublicController < ApplicationController
    before_action :authenticate_account!
    
    def index   
        @communities = Community.all.limit(5)
        @posts = Post.limit(20).sort_by{ |p| p.score }
        @query = params[:query]
        if @query.nil?
        @communities = Community.page params[:page]
        else
        @communities = Community.where("communities.name ILIKE ?",["%#{@query}%"]).page(params[:page])
        @posts = Post.where("posts.title ILIKE ?",["%#{@query}%"]).page(params[:page])
        end
    end
    def profile
        @profile = Account.find_by_username params[:username]
        @posts = @profile.posts
    end
   
end