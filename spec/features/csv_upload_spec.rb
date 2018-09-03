require 'rails_helper'


RSpec.feature "user registration" do
  it "using instagram" do
    visit pokemons_path
    expect(page).to have_content("Pokemons")
    expect(page).to have_button("Import data from CSV")
  end
end
