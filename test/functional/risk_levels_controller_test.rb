require 'test_helper'

class RiskLevelsControllerTest < ActionController::TestCase
  setup do
    @risk_level = risk_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_level" do
    assert_difference('RiskLevel.count') do
      post :create, :risk_level => @risk_level.attributes
    end

    assert_redirected_to risk_level_path(assigns(:risk_level))
  end

  test "should show risk_level" do
    get :show, :id => @risk_level.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @risk_level.to_param
    assert_response :success
  end

  test "should update risk_level" do
    put :update, :id => @risk_level.to_param, :risk_level => @risk_level.attributes
    assert_redirected_to risk_level_path(assigns(:risk_level))
  end

  test "should destroy risk_level" do
    assert_difference('RiskLevel.count', -1) do
      delete :destroy, :id => @risk_level.to_param
    end

    assert_redirected_to risk_levels_path
  end
end
