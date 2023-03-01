require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_request(:get, ListingService::LISTING_URL)
      .to_return(body: [].to_json
      )
    @listing = listings(:one)
    @user = users(:one)
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should show listing" do
    get listings_url(@listing)
    assert_response :success
  end

  test "should patch listing" do
    patch like_listing_url(@listing)
    assert_redirected_to listing_url(@listing)
  end


  test "should destroy listing" do
    assert_difference("Listing.count", -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end
end
