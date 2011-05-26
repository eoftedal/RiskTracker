require 'test_helper'

class RiskConfigurationsControllerTest < ActionController::TestCase
  setup do
    @risk_configuration = risk_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_configuration" do
    assert_difference('RiskConfiguration.count') do
      post :create, :risk_configuration => @risk_configuration.attributes
    end

    assert_redirected_to risk_configuration_path(assigns(:risk_configuration))
  end

  test "should show risk_configuration" do
    get :show, :id => @risk_configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @risk_configuration.to_param
    assert_response :success
  end

  test "should update risk_configuration" do
    put :update, :id => @risk_configuration.to_param, :risk_configuration => @risk_configuration.attributes
    assert_redirected_to risk_configuration_path(assigns(:risk_configuration))
  end

  test "should destroy risk_configuration" do
    assert_difference('RiskConfiguration.count', -1) do
      delete :destroy, :id => @risk_configuration.to_param
    end

    assert_redirected_to risk_configurations_path
  end
end
