class CommentsController < ApplicationController
  before_action :authenticate_account!, except:  [ :index, :show ]
  before_action :set_comment, only: [:show]

    def create
      @comment = Comment.new comment_params
      @comment.account_id = current_account.id
     
      respond_to do |format|
        format.js {
          if @comment.save
            @comments = Comment.where(post_id: @comment.post_id)
            render "comments/create"
          else
            # unable to save
          end
        }
      end
    end
    
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.present?
        @comment.destroy
      end
      respond_to do |format|
        format.html { redirect_to root_url, notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
  
    def comment_params
      params.require(:comment).permit(:message, :post_id)
    end

    
  
end
  