class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.save
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def  update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      
      render :edit
    end
  end

def destroy
  prototype = Prototype.find(params[:id])
  prototype.destroy
  if prototype.destroy
    redirect_to root_path
  end
end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :user, :image).merge(user_id: current_user.id)
  end

end
