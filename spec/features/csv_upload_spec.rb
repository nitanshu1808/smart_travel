require 'rails_helper'
include ActionDispatch::TestProcess


RSpec.feature "user registration" do
  it "using instagram" do
    visit pokemons_path
    expect(page).to have_content(I18n.t("web.pokemons"))
    expect(page).to have_button(I18n.t("web.import_csv"))
    attach_file('file', "#{Rails.root}/spec/fixtures/files/pokemon.csv")
    find('input[name="commit"]').click
    expect(page).to have_content(I18n.t("web.record_created"))
  end
end
