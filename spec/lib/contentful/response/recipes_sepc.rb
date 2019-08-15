require "spec_helper"
require "./lib/contentful/response/recipe"

describe Condentful::Response::Recipe do
  let(:data) do
    double("Recipes", id: "1", fields: { title: "demo",
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

  context "Recipe.call" do
    subject { Condentful::Response::Recipe.call(data) }

    it "should list recepies" do
      expect(subject.to_h).to eq(response)
    end
  end

  context "Recipe::Collection.call" do
    subject { Condentful::Response::Recipe::Collection.call([data]) }

    it "should list recepies" do
      expect(subject.count).to eq(1)
      expect(subject.to_a.first.to_h).to eq(response)
    end
  end
end
