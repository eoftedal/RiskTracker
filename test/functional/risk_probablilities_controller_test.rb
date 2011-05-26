require 'test_helper'

class RiskProbablilitiesControllerTest < ActionController::TestCase
  setup do
    @risk_probablility = risk_probablilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_probablilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_probablility" do
    assert_difference('RiskProbablility.count') do
      post :create, :risk_probablility => @risk_probablility.attributes
    end

    assert_redirected_to risk_probablility_path(assigns(:risk_probablility))
  end

  test "should show risk_probablility" do
    get :show, :id => @risk_probablility.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @risk_probablility.to_param
    assert_response :success
  end

  test "should update risk_probablility" do
    put :update, :id => @risk_probablility.to_param, :risk_probablility => @risk_probablility.attributes
    assert_redirected_to risk_probablility_path(assigns(:risk_probablility))
  end

  test "should destroy risk_probablility" do
    assert_difference('RiskProbablility.count', -1) do
      delete :destroy, :id => @risk_probablility.to_param
    end

    assert_redirected_to risk_probablilities_path
  end
end
