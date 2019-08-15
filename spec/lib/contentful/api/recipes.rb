require "spec_helper"
require "./lib/contentful/api/recipes"
require "contentful"

describe Condentful::Api::Recipes do
  subject { Condentful::Api::Recipes.new(credentials) }

  let(:credentials) do
    {
      space: "demo",
      access_token: "demo",
      environment: "demo",
      client: client
    }
  end

  let(:entity) do
    double("Contentful::Entry", id: "1", fields: { title: "demo",
                                                   photo: double("Photo", url: "http://demo.com"),
                                                   tags: [double("Tag", fields: { name: "demo" })],
                                                   chef: double("Chef", fields: { name: "demo" }),
                                                   description: "demo" })
  end

  let(:response) do
    {
      chef: "demo",
      description: "demo",
      id: "1",
      photo_url: "http://demo.com",
      tags: ["demo"],
      title: "demo"
    }
  end

  let(:client) { double("Client") }
  let(:client_instance) { double("Demo", entries: [entity], entry: entity) }

  before do
    allow(client).to receive(:new).and_return(client_instance)
  end

  describe "list_recipes" do
    it "returns array of recipes" do
      expect(subject.list_recipes.count).to eq(1)
      expect(subject.list_recipes.first.to_h).to eq(response)
    end
  end

  describe "fetch_recipe" do
    context "when id is valid" do
      it "returns recipe" do
        expect(subject.fetch_recipe(1).to_h).to eq(response)
      end
    end

    context "when id is invalid" do
      let(:entity) { nil }

      it "returns nil" do
        expect(subject.fetch_recipe(1)).to eq(nil)
      end
    end
  end
end
