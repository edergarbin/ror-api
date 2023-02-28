class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show update destroy ]

  # GET /sales
  def index
    @sales = Sale.all

    render json: @sales
  end

  # GET /sales/1
  def show
    render json: @sale
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)
    product = Product.find(sale_params[:product_id])
    if product.quantity < sale_params[:quantity]
      return render json: { message: 'Sem produtos em estoque.'}, status: :unprocessable_entity
    end

    @sale.total_in_cents = product.price_in_cents * sale_params[:quantity]

    if @sale.save
      product.quantity -= sale_params[:quantity]
      product.save!
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:quantity, :product_id, :user_id)
    end
end
