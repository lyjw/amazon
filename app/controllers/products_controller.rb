class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit(:title, :description, :price)
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_path(@product), notice: "Product created."
    else
      flash[:alert] = "Invalid params. Product was not created."
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    product_params = params.require(:product).permit(:title, :description, :price)

    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy

    flash[:notice] = "Product deleted."
    redirect_to products_path
  end

end
