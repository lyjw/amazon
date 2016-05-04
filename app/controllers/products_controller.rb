class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # @category = Category.find(@product.category_id)
    # @product.category = Category.find(:category_id)
    @product.user = current_user

    if @product.save
      # render json: params
      redirect_to product_path(@product), notice: "Product created."
    else
      flash[:alert] = "Invalid params. Product was not created."
      render :new
    end
  end

  def show
    @favourite = Favourite.new
    @review = Review.new
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy

    flash[:notice] = "Product deleted."
    redirect_to products_path
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    product_params = params.require(:product).permit(:title, :description, :price, :sale_price, :category_id)
  end

end
