require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get sales_url, as: :json
    assert_response :success
  end

  test "should create sale" do
    assert_difference("Sale.count") do
      post sales_url, params: { sale: { product_id: @sale.product_id, quantity: @sale.quantity, total_in_cents: @sale.total_in_cents, user_id: @sale.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show sale" do
    get sale_url(@sale), as: :json
    assert_response :success
  end

  test "should update sale" do
    patch sale_url(@sale), params: { sale: { product_id: @sale.product_id, quantity: @sale.quantity, total_in_cents: @sale.total_in_cents, user_id: @sale.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy sale" do
    assert_difference("Sale.count", -1) do
      delete sale_url(@sale), as: :json
    end

    assert_response :no_content
  end
end
