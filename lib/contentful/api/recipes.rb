require "contentful"
require "./lib/contentful/response/recipe"

module Condentful
  module Api
    class Recipes
      # @param [String] space
      # @param [String] access_token
      # @param [String] environment
      def initialize(space: ENV["CONTENTFUL_SPACE"],
                     access_token: ENV["CONTENTFUL_ACCESS_TOKEN"],
                     environment: ENV["CONTENTFUL_ENVIIRONMENT"],
                     client: Contentful::Client)

        @space = space
        @access_token = access_token
        @environment = environment
        @client = client
      end

      # @return [Condentful::Response::Recipe::Collection]
      def list_recipes
        response = client.entries(content_type: "recipe")

        Condentful::Response::Recipe::Collection.call(response)
      end

      # @param [String] id
      # @return [Condentful::Response::Recipe]
      def fetch_recipe(id)
        response = client.entry(id)

        return nil if response.nil?

        Condentful::Response::Recipe.call(response)
      end

      private

      # @return [Contentful::Client]
      def client
        @client.new(
          space: @space,
          access_token: @access_token,
          environment: @environment,
          dynamic_entries: :auto
        )
      end
    end
  end
end
