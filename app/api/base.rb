require "sinatra/base"
require "./app/api/recipes"

module Api
  class Base < Sinatra::Base
    set :raise_errors, false

    include Api::Recipes

    # NOTE this should be extracted in common place for all future API's
    get "/*" do
      redirect to("/recipes")
    end
  end
end
