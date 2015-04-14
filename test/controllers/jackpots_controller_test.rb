require 'test_helper'

class JackpotsControllerTest < ActionController::TestCase
  setup do
    @jackpot = jackpots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jackpots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jackpot" do
    assert_difference('Jackpot.count') do
      post :create, jackpot: { jackpot_type: @jackpot.jackpot_type, player_percent: @jackpot.player_percent, seed_amount: @jackpot.seed_amount }
    end

    assert_redirected_to jackpot_path(assigns(:jackpot))
  end

  test "should show jackpot" do
    get :show, id: @jackpot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jackpot
    assert_response :success
  end

  test "should update jackpot" do
    patch :update, id: @jackpot, jackpot: { jackpot_type: @jackpot.jackpot_type, player_percent: @jackpot.player_percent, seed_amount: @jackpot.seed_amount }
    assert_redirected_to jackpot_path(assigns(:jackpot))
  end

  test "should destroy jackpot" do
    assert_difference('Jackpot.count', -1) do
      delete :destroy, id: @jackpot
    end

    assert_redirected_to jackpots_path
  end
end
