require "spec_helper"
require "./app/api/recipes"

describe Condentful::Api::Recipes do
  let(:response) do
    double("Recipes", id: 1,
           title: "title",
           photo_url: "http://demo.com",
           tags: ["tag"],
           chef: "demo",
           description: "demo")
  end
  before do
    allow_any_instance_of(Condentful::Api::Recipes).to receive(:list_recipes).and_return([response])
    allow_any_instance_of(Condentful::Api::Recipes).to receive(:fetch_recipe).and_return(response)
  end

  it "should list recepies" do
    get "/recipes"
    expect(last_response).to be_ok
  end

  it "should fetch recipe" do
    get "/recipes/1"
    expect(last_response).to be_ok
  end

  it "should redirect to recipes" do
    get "/recipes/1/demo"

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to eq("http://example.org/recipes")
  end
end
