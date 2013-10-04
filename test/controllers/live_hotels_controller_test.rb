require 'test_helper'

class LiveHotelsControllerTest < ActionController::TestCase
  setup do
    @live_hotel = live_hotels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:live_hotels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create live_hotel" do
    assert_difference('LiveHotel.count') do
      post :create, live_hotel: {  }
    end

    assert_redirected_to live_hotel_path(assigns(:live_hotel))
  end

  test "should show live_hotel" do
    get :show, id: @live_hotel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @live_hotel
    assert_response :success
  end

  test "should update live_hotel" do
    patch :update, id: @live_hotel, live_hotel: {  }
    assert_redirected_to live_hotel_path(assigns(:live_hotel))
  end

  test "should destroy live_hotel" do
    assert_difference('LiveHotel.count', -1) do
      delete :destroy, id: @live_hotel
    end

    assert_redirected_to live_hotels_path
  end
end
