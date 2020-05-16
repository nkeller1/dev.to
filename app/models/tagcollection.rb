class Tagcollection < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :article_tagcollections, dependent: :destroy
  has_many :articles, through: :article_tagcollections, dependent: :destroy

  acts_as_taggable_on :tags

  def find_articles
    self.articles = Article.where("created_at >= ?", 1.week.ago).
      tagged_with(tag_list, any: true).
      order(page_views_count: :desc).
      limit(5)
  end
end
