class ListingService
  LISTING_URL = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'.freeze
  def initialize
    @listing = fetch_listings
  end

  def fetch_listings
    uri = URI(LISTING_URL)
    response = Net::HTTP.get(uri)
    @listing = JSON.parse(response, symbolize_names: true)
  end

  def load_listings
    @listing.each do |item|
      user_data = item[:user]
      user = load_user(user_data)
      load_article(item, user)
    end
  end

  private

  def load_user(user_data)
    User.find_or_create_by!(external_id: user_data[:id]) do |user|
      user.name = user_data[:first_name]
      user.rating = user_data.dig(:rating, :rating)
      user.current_avatar = user_data.dig(:current_avatar, :small)
    end
  end

  def load_article(article_data, user)
    article =  Listing.find_or_create_by(external_id: article_data[:id])
    article.update(
      user: user,
      title: article_data[:title],
      description: article_data[:description],
      thumbnail_link:article_data[:photos].first&.dig(:files, :small),
      likes:article_data.dig(:reactions, :likes),
      view:article_data.dig(:reactions, :views),
    )
  end
end
