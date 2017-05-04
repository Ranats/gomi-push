require 'test_helper'

class GomisControllerTest < ActionController::TestCase
  setup do
    @gomi = gomis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gomis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gomi" do
    assert_difference('Gomi.count') do
      post :create, gomi: { every: @gomi.every, fri: @gomi.fri, mon: @gomi.mon, name: @gomi.name, sat: @gomi.sat, start_date: @gomi.start_date, sun: @gomi.sun, thurs: @gomi.thurs, tues: @gomi.tues, user_id: @gomi.user_id, wed: @gomi.wed }
    end

    assert_redirected_to gomi_path(assigns(:gomi))
  end

  test "should show gomi" do
    get :show, id: @gomi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gomi
    assert_response :success
  end

  test "should update gomi" do
    patch :update, id: @gomi, gomi: { every: @gomi.every, fri: @gomi.fri, mon: @gomi.mon, name: @gomi.name, sat: @gomi.sat, start_date: @gomi.start_date, sun: @gomi.sun, thurs: @gomi.thurs, tues: @gomi.tues, user_id: @gomi.user_id, wed: @gomi.wed }
    assert_redirected_to gomi_path(assigns(:gomi))
  end

  test "should destroy gomi" do
    assert_difference('Gomi.count', -1) do
      delete :destroy, id: @gomi
    end

    assert_redirected_to gomis_path
  end
end
