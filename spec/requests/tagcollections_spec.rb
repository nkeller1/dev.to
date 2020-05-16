require "rails_helper"

RSpec.describe "Tagcollections", type: :request do
  before do
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[rails preact heroku])
    create(:article, tags: %w[javascript rails sql])
    create(:article, tags: %w[rails preact sql])
    create(:article, tags: %w[javascript preact sql])
    user = create(:user)
    user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby preact])
    sign_in user
  end

  it "successfully GETS /tagcollections" do
    get "/tagcollections"

    expect(response).to have_http_status(:ok)
  end

  it "successfully create new tag collection" do
    post "/tagcollections", params: { name: "All about JS",
                                      tag_list: "javascript" }

    expect(response).to be_successful
  end

  it "successfully GETS tagcollection show page collection" do
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[rails preact heroku])
    create(:article, tags: %w[javascript rails sql])
    create(:article, tags: %w[rails preact sql])
    create(:article, tags: %w[javascript preact sql])
    user = create(:user)
    tagcollection = user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby preact])
    tagcollection.find_articles
    sign_in user
    get "/tagcollections/#{user.tagcollections.first.id}"

    expect(response).to be_successful
  end

  it "successfully DESTROYS a tagcollection" do
    create(:article, tags: %w[ruby preact rails])
    create(:article, tags: %w[ruby preact rails])
    user = create(:user)
    tagcollection = user.tagcollections.create(name: "All the Ruby", tag_list: %w[ruby preact])
    tagcollection.find_articles
    sign_in user

    delete "/tagcollections/#{tagcollection.id}"

    expect(response).to be_successful
    expect(user.tagcollections.count).to eq(0)
  end
end
