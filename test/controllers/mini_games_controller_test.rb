require 'test_helper'

class MiniGamesControllerTest < ActionController::TestCase
  setup do
    @mini_game = mini_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mini_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mini_game" do
    assert_difference('MiniGame.count') do
      post :create, mini_game: { description: @mini_game.description, machine_id: @mini_game.machine_id, name: @mini_game.name }
    end

    assert_redirected_to mini_game_path(assigns(:mini_game))
  end

  test "should show mini_game" do
    get :show, id: @mini_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mini_game
    assert_response :success
  end

  test "should update mini_game" do
    patch :update, id: @mini_game, mini_game: { description: @mini_game.description, machine_id: @mini_game.machine_id, name: @mini_game.name }
    assert_redirected_to mini_game_path(assigns(:mini_game))
  end

  test "should destroy mini_game" do
    assert_difference('MiniGame.count', -1) do
      delete :destroy, id: @mini_game
    end

    assert_redirected_to mini_games_path
  end
end
