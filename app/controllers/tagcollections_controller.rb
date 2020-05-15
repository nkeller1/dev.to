class TagcollectionsController < ApplicationController
  def index
    @tagcollection = current_user.tagcollections.all.to_json
  end

  def create
    tagcollection = current_user.tagcollections.create(tagcollection_params)
    if tagcollection.save
      tagcollection.find_articles
      tagcollection.to_json
    else
      response.status = 401
    end
  end

  def show
    tagcollection = Tagcollection.find(params[:id])
    @articles = tagcollection.articles.includes([:taggings]).to_json
    @name = tagcollection.name
  end

  private

  def tagcollection_params
    params.permit(:name, :tag_list)
  end
end
