require 'test_helper'

class PointMarksControllerTest < ActionController::TestCase
  setup do
    @point_mark = point_marks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:point_marks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create point_mark" do
    assert_difference('PointMark.count') do
      post :create, :point_mark => @point_mark.attributes
    end

    assert_redirected_to point_mark_path(assigns(:point_mark))
  end

  test "should show point_mark" do
    get :show, :id => @point_mark.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @point_mark.to_param
    assert_response :success
  end

  test "should update point_mark" do
    put :update, :id => @point_mark.to_param, :point_mark => @point_mark.attributes
    assert_redirected_to point_mark_path(assigns(:point_mark))
  end

  test "should destroy point_mark" do
    assert_difference('PointMark.count', -1) do
      delete :destroy, :id => @point_mark.to_param
    end

    assert_redirected_to point_marks_path
  end
end
