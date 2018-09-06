require "rails_helper"

RSpec.describe "Integration test for routing", :type => :routing do
  it "verifies routes to controllers" do
    expect(:get => "/pokemons").
      to route_to(:controller => "pokemons", :action => "index")
  end

  it "routes /pokemons/1 to products#show" do
    expect(get: "/pokemons/1").to route_to(
      controller: "pokemons",
      action: "show",
      id: "1"
    )
  end
end
