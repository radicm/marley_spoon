require "dry-types"
require "dry-struct"
require "json"

module Types
  include Dry.Types()
end

module Condentful
  module Response
    class Recipe < Dry::Struct
      # response parsing schema
      attribute :id,          Types::String
      attribute :title,       Types::String
      attribute :photo_url,   Types::String
      attribute :tags,        Types::Array
      attribute :chef,        Types::String
      attribute :description, Types::String

      # @param [Contentful::Entry] response
      # @return [Condentful::Response::Recipe]
      def self.call(response)
        chef = response.fields[:chef].fields[:name] || ""
        tags = response.fields[:tags] || []

        new(id:          response.id,
            title:       response.fields[:title],
            photo_url:   response.fields[:photo].url,
            tags:        tags.map { |n| n.fields[:name] },
            chef:        chef,
            description: response.fields[:description])
      end

      class Collection
        include Enumerable

        # @param [Contentful::Array] response
        # @return [Condentful::Response::Recipe::Collection]
        def self.call(response)
          new(response)
        end

        # @param [Contentful::Array] response
        # @return [Condentful::Response::Recipe::Collection]
        def initialize(response)
          @collection = response.map { |data| Recipe.call(data) }
        end

        def each(&block)
          @collection.each(&block)
        end
      end
    end
  end
end
