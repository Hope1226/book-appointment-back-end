require "test_helper"

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space = spaces(:one)
  end

  test "should get index" do
    get spaces_url, as: :json
    assert_response :success
  end

  test "should create space" do
    assert_difference("Space.count") do
      post spaces_url, params: { space: { image: @space.image, name: @space.name, price: @space.price, removed: @space.removed, users_id: @space.users_id } }, as: :json
    end

    assert_response :created
  end

  test "should show space" do
    get space_url(@space), as: :json
    assert_response :success
  end

  test "should update space" do
    patch space_url(@space), params: { space: { image: @space.image, name: @space.name, price: @space.price, removed: @space.removed, users_id: @space.users_id } }, as: :json
    assert_response :success
  end

  test "should destroy space" do
    assert_difference("Space.count", -1) do
      delete space_url(@space), as: :json
    end

    assert_response :no_content
  end
end
