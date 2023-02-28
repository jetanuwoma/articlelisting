require 'test_helper'

class ListingServiceTest < ActiveSupport::TestCase
  def setup
    stub_request(:get, ListingService::LISTING_URL)
      .to_return(body: [
        {
          "id": 389,
          "title": 'Ambipur air freshener plugin',
          "description": 'Device only but refills are available most places',
          "reactions": {
            "likes": 0,
            "views": 18,
          },
          "photos": [
            {
              "files": {
                "small": 'https://cdn.olioex.com/uploads/avatar/file/oZq8DF3dzLEi3Fnf4XxMrg/small_image.jpg'
              }
            }
          ],
          "user": {
            "id": 8039,
            "first_name": 'Lloyd',
            "current_avatar": {
              "small": 'https://cdn.olioex.com/uploads/avatar/file/oZq8DF3dzLEi3Fnf4XxMrg/small_image.jpg'
            },
            "rating": {
              "rating": 10
            }
          }
        }].to_json
      )
  end

  test 'creates new article' do
    articles = ListingService.new
    assert_difference 'Listing.count' do
      assert articles.load_articles
    end
  end

  test 'creates new user from listing' do
    articles = ListingService.new
    assert_difference 'User.count' do
      assert articles.load_articles
    end
  end

  test 'associate created user to listing' do
    articles = ListingService.new
    articles.load_articles
    assert_equal Listing.last.user.name, 'Lloyd'
  end
end
