require 'test_helper'

class SavedprogramsControllerTest < ActionController::TestCase
  setup do
    @savedprogram = savedprograms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:savedprograms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create savedprogram" do
    assert_difference('Savedprogram.count') do
      post :create, savedprogram: { program_id: @savedprogram.program_id, trainer_id: @savedprogram.trainer_id }
    end

    assert_redirected_to savedprogram_path(assigns(:savedprogram))
  end

  test "should show savedprogram" do
    get :show, id: @savedprogram
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @savedprogram
    assert_response :success
  end

  test "should update savedprogram" do
    patch :update, id: @savedprogram, savedprogram: { program_id: @savedprogram.program_id, trainer_id: @savedprogram.trainer_id }
    assert_redirected_to savedprogram_path(assigns(:savedprogram))
  end

  test "should destroy savedprogram" do
    assert_difference('Savedprogram.count', -1) do
      delete :destroy, id: @savedprogram
    end

    assert_redirected_to savedprograms_path
  end
end
