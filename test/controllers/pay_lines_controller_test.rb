require 'test_helper'

class PayLinesControllerTest < ActionController::TestCase
  setup do
    @pay_line = pay_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_line" do
    assert_difference('PayLine.count') do
      post :create, pay_line: { label: @pay_line.label, slot_id: @pay_line.slot_id, x: @pay_line.x, y: @pay_line.y }
    end

    assert_redirected_to pay_line_path(assigns(:pay_line))
  end

  test "should show pay_line" do
    get :show, id: @pay_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_line
    assert_response :success
  end

  test "should update pay_line" do
    patch :update, id: @pay_line, pay_line: { label: @pay_line.label, slot_id: @pay_line.slot_id, x: @pay_line.x, y: @pay_line.y }
    assert_redirected_to pay_line_path(assigns(:pay_line))
  end

  test "should destroy pay_line" do
    assert_difference('PayLine.count', -1) do
      delete :destroy, id: @pay_line
    end

    assert_redirected_to pay_lines_path
  end
end
