require 'test_helper'

class RiskConsequencesControllerTest < ActionController::TestCase
  setup do
    @risk_consequence = risk_consequences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_consequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_consequence" do
    assert_difference('RiskConsequence.count') do
      post :create, :risk_consequence => @risk_consequence.attributes
    end

    assert_redirected_to risk_consequence_path(assigns(:risk_consequence))
  end

  test "should show risk_consequence" do
    get :show, :id => @risk_consequence.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @risk_consequence.to_param
    assert_response :success
  end

  test "should update risk_consequence" do
    put :update, :id => @risk_consequence.to_param, :risk_consequence => @risk_consequence.attributes
    assert_redirected_to risk_consequence_path(assigns(:risk_consequence))
  end

  test "should destroy risk_consequence" do
    assert_difference('RiskConsequence.count', -1) do
      delete :destroy, :id => @risk_consequence.to_param
    end

    assert_redirected_to risk_consequences_path
  end
end
