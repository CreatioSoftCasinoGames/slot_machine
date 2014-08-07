require 'test_helper'

class PayTablesControllerTest < ActionController::TestCase
  setup do
    @pay_table = pay_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_table" do
    assert_difference('PayTable.count') do
      post :create, pay_table: { count: @pay_table.count, points: @pay_table.points, slot_id: @pay_table.slot_id, stamp_id: @pay_table.stamp_id }
    end

    assert_redirected_to pay_table_path(assigns(:pay_table))
  end

  test "should show pay_table" do
    get :show, id: @pay_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_table
    assert_response :success
  end

  test "should update pay_table" do
    patch :update, id: @pay_table, pay_table: { count: @pay_table.count, points: @pay_table.points, slot_id: @pay_table.slot_id, stamp_id: @pay_table.stamp_id }
    assert_redirected_to pay_table_path(assigns(:pay_table))
  end

  test "should destroy pay_table" do
    assert_difference('PayTable.count', -1) do
      delete :destroy, id: @pay_table
    end

    assert_redirected_to pay_tables_path
  end
end
