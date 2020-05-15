class TagcollectionsController < ApplicationController
  def index
    @tagcollection = current_user.tagcollections.all.to_json
  end

  def create
    # require 'pry'; binding.pry

    tagcollection = current_user.tagcollections.create(tagcollection_params)
    tagcollection.to_json
  end

  # def show
  #
  # end

  private

  def tagcollection_params
    params.permit(:name, :tag_list)
  end
end
