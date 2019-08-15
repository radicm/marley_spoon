require "./lib/contentful/api/recipes"
require "sinatra"

module Api
  module Recipes
    set :views, "app/views/recipes"

    get "/recipes" do
      @data = Condentful::Api::Recipes.new.list_recipes

      erb :index
    end

    get "/recipes/:recipe_id" do
      @data = Condentful::Api::Recipes.new.fetch_recipe(params[:recipe_id])

      if @data.nil?
        redirect to("/recipes")
      else
        erb :show
      end
    end
  end
end
