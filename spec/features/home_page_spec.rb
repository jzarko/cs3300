require "rails_helper"
require "/root/protected-thicket-73961/config/initializers/devise"
require "/root/protected-thicket-73961/spec/support/factorybot"

RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end
end