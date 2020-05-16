desc "Update tag collections"
task tagcollection_renew: :environment do

  tagcollections = Tagcollection.all

  tagcollections.map do |collection|
    collection.articles = []
    collection.find_articles
  end
end
