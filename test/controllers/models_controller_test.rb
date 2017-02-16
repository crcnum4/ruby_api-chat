require 'test_helper'

class ModelsControllerTest < ActionController::TestCase
  setup do
    @model = models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:models)
  end

  test "should create model" do
    assert_difference('Model.count') do
      post :create, model: { password: @model.password, user: @model.user, username: @model.username }
    end

    assert_response 201
  end

  test "should show model" do
    get :show, id: @model
    assert_response :success
  end

  test "should update model" do
    put :update, id: @model, model: { password: @model.password, user: @model.user, username: @model.username }
    assert_response 204
  end

  test "should destroy model" do
    assert_difference('Model.count', -1) do
      delete :destroy, id: @model
    end

    assert_response 204
  end
end
