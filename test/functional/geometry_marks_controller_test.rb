require 'test_helper'

class GeometryMarksControllerTest < ActionController::TestCase
  setup do
    @geometry_mark = geometry_marks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geometry_marks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geometry_mark" do
    assert_difference('GeometryMark.count') do
      post :create, :geometry_mark => @geometry_mark.attributes
    end

    assert_redirected_to geometry_mark_path(assigns(:geometry_mark))
  end

  test "should show geometry_mark" do
    get :show, :id => @geometry_mark.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @geometry_mark.to_param
    assert_response :success
  end

  test "should update geometry_mark" do
    put :update, :id => @geometry_mark.to_param, :geometry_mark => @geometry_mark.attributes
    assert_redirected_to geometry_mark_path(assigns(:geometry_mark))
  end

  test "should destroy geometry_mark" do
    assert_difference('GeometryMark.count', -1) do
      delete :destroy, :id => @geometry_mark.to_param
    end

    assert_redirected_to geometry_marks_path
  end
end
