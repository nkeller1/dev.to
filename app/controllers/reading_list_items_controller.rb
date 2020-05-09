class ReadingListItemsController < ApplicationController
  # index action that sends instance variable to view and calls helper methods (generate algolia key and setting view to archived or valid)
  def index
    @reading_list_items_index = true
    set_view
    generate_algolia_search_key
  end

  # update action, set status if the reaction user's id is the same as current user
  def update
    @reaction = Reaction.find(params[:id])
    not_authorized if @reaction.user_id != session_current_user_id

    @reaction.status = params[:current_status] == "archived" ? "valid" : "archived"
    @reaction.save
    head :ok
  end

  private

  # called when index action is called
  # algolia search key is created for a current user by calling generate secured api key method
  def generate_algolia_search_key
    params = { filters: "viewable_by:#{session_current_user_id}" }
    @secured_algolia_key = Algolia.generate_secured_api_key(
      ApplicationConfig["ALGOLIASEARCH_SEARCH_ONLY_KEY"], params
    )
  end

  def set_view
    @view = if params[:view] == "archive"
              "archived"
            else
              "valid"
            end
  end
end
