require 'test_helper'

class PlayersPrizesControllerTest < ActionController::TestCase
  setup do
    @players_prize = players_prizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players_prizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create players_prize" do
    assert_difference('PlayersPrize.count') do
      post :create, players_prize: { next_winner_difference: @players_prize.next_winner_difference, player_one_percent: @players_prize.player_one_percent, player_three_percent: @players_prize.player_three_percent, player_two_percent: @players_prize.player_two_percent, prize_pool_percent: @players_prize.prize_pool_percent, user_score_percent: @players_prize.user_score_percent }
    end

    assert_redirected_to players_prize_path(assigns(:players_prize))
  end

  test "should show players_prize" do
    get :show, id: @players_prize
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @players_prize
    assert_response :success
  end

  test "should update players_prize" do
    patch :update, id: @players_prize, players_prize: { next_winner_difference: @players_prize.next_winner_difference, player_one_percent: @players_prize.player_one_percent, player_three_percent: @players_prize.player_three_percent, player_two_percent: @players_prize.player_two_percent, prize_pool_percent: @players_prize.prize_pool_percent, user_score_percent: @players_prize.user_score_percent }
    assert_redirected_to players_prize_path(assigns(:players_prize))
  end

  test "should destroy players_prize" do
    assert_difference('PlayersPrize.count', -1) do
      delete :destroy, id: @players_prize
    end

    assert_redirected_to players_prizes_path
  end
end
