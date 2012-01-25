require 'test_helper'

class MapStatesControllerTest < ActionController::TestCase
  setup do
    @map_state = map_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:map_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create map_state" do
    assert_difference('MapState.count') do
      post :create, :map_state => @map_state.attributes
    end

    assert_redirected_to map_state_path(assigns(:map_state))
  end

  test "should show map_state" do
    get :show, :id => @map_state.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @map_state.to_param
    assert_response :success
  end

  test "should update map_state" do
    put :update, :id => @map_state.to_param, :map_state => @map_state.attributes
    assert_redirected_to map_state_path(assigns(:map_state))
  end

  test "should destroy map_state" do
    assert_difference('MapState.count', -1) do
      delete :destroy, :id => @map_state.to_param
    end

    assert_redirected_to map_states_path
  end
end
