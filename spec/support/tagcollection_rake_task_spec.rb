require "rails_helper"
Rails.application.load_tasks

RSpec.describe "TagCollection Rake Task", type: :feature do
  it "creates a new set of articles when task is ran" do
    User.destroy_all
    Tagcollection.destroy_all
    Article.destroy_all
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[ruby javascript rails])
    user = create(:user)
    tagcollection = user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby])
    tagcollection.find_articles

    expect(tagcollection.articles.length).to eq(2)

    create(:article, tags: %w[ruby jquery sql])
    create(:article, tags: %w[ruby git sql])

    Rake::Task["tagcollection_renew"].invoke

    new_tagcollection = Tagcollection.all.last

    expect(new_tagcollection.id).to eq(tagcollection.id)
  end
end
