require 'test_helper'

class MissionsControllerTest < ActionController::TestCase
  test 'get index is successful' do
    get :index
    assert_includes assigns(:missions), missions(:alpha)
    assert_response :success
  end

  test "get show is successful" do
    get :show, id: missions(:alpha).id
    assert_equal missions(:alpha), assigns(:mission)
    assert_response :success
  end

  test 'get new is successful' do
    get :new
    assert_kind_of Mission, assigns(:mission)
    assert_response :success
  end

  test 'post create is successful with valid attributes' do
    mission_params = { code_name: 'eagle', description: 'Operation eagle!', status: 'active' }
    assert_difference 'Mission.count' do
      post :create, mission: mission_params
    end
    assert_redirected_to missions_path
  end

  test 'post create is unsuccessful with invalid attributes' do
    invalid_params = { code_name: '', description: '', status: '' }
    assert_no_difference 'Mission.count' do
      post :create, mission: invalid_params
    end
    assert_template 'new'
    assert_response :success
  end

  test 'get edit is successful' do
    get :edit, id: missions(:alpha).id
    assert_equal missions(:alpha), assigns(:mission)
    assert_response :success
  end

  test 'put update is successful with valid attributes' do
    valid_params = { status: 'completed' }
    post :update, id: missions(:alpha).id, mission: valid_params
    assert_equal valid_params[:status], missions(:alpha).reload.status
    assert_redirected_to mission_path(missions(:alpha))
  end

  test 'put update is unsuccessful with invalid attributes' do
    invalid_params = { status: '' }
    post :update, id: missions(:alpha).id, mission: invalid_params
    refute_equal invalid_params[:status], missions(:alpha).reload.status
    assert_template 'edit'
    assert_response :success
  end

  test 'delete destroy is successful' do
    assert_difference 'Mission.count', -1 do
      delete :destroy, id: missions(:alpha).id
    end
    assert_redirected_to missions_path
  end
end

