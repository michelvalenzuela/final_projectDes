class PublicController < ApplicationController

    def index
        @communities = Community.all.limit(5)
        @posts = Post.limit(20).sort_by{ |p| p.score }.reverse
    end
   
end