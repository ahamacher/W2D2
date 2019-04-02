class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new(description: "Enter cat's description")
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 422
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update

  end

  private
  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :description, :sex)
  end
end
