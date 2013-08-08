class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def comment
   @products = Product.find_with_reputation(:votes, :all, order: "votes desc")
  end

  def new
    @comment = @commentable.comments.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @commentable, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
  
  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: "Comment created"
    else
      render :new
    end
  end

  private

  def load_commentable
    klass = [Product].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end
end
