require 'test_helper'

class ReelsControllerTest < ActionController::TestCase
  setup do
    @reel = reels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reel" do
    assert_difference('Reel.count') do
      post :create, reel: { position: @reel.position, stamp_id: @reel.stamp_id }
    end

    assert_redirected_to reel_path(assigns(:reel))
  end

  test "should show reel" do
    get :show, id: @reel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reel
    assert_response :success
  end

  test "should update reel" do
    patch :update, id: @reel, reel: { position: @reel.position, stamp_id: @reel.stamp_id }
    assert_redirected_to reel_path(assigns(:reel))
  end

  test "should destroy reel" do
    assert_difference('Reel.count', -1) do
      delete :destroy, id: @reel
    end

    assert_redirected_to reels_path
  end
end
