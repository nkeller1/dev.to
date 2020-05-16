require "rails_helper"

RSpec.describe Tagcollection, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:article_tagcollections) }
    it { is_expected.to have_many(:articles).through(:article_tagcollections) }
  end

  describe "instance methods" do
    it ".find_articles" do
      Article.destroy_all
      article1 = create(:article, tags: %w[ruby preact rails], page_views_count: 10)
      create(:article, tags: %w[ruby preact rails], page_views_count: 4)
      create(:article, tags: %w[rails preact heroku], page_views_count: 8)
      create(:article, tags: %w[javascript rails sql], page_views_count: 0)
      create(:article, tags: %w[rails preact sql], page_views_count: 3)
      create(:article, tags: %w[javascript preact sql], page_views_count: 1)
      user = create(:user)
      user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby])
      user.tagcollections.first.find_articles
      expect(user.tagcollections.first.articles.length).to eq(2)

      user.tagcollections.create(name: "All the JS", tag_list: %w[javascript preact])
      user.tagcollections.last.find_articles

      expect(user.tagcollections.last.articles.length).to eq(5)
      expect(user.tagcollections.last.articles.first).to eq(article1)
    end

    it ".find_articles only gathers articles that are over a week old" do
      Article.destroy_all
      create(:article, tags: %w[ruby preact rails], page_views_count: 10)
      create(:article, tags: %w[ruby preact rails], page_views_count: 4, created_at: 2.weeks.ago)

      user = create(:user)
      tagcollection = user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby])

      tagcollection.find_articles

      expect(tagcollection.articles.length).to eq(1)
    end
  end
end
