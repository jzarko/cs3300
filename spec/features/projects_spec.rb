require 'rails_helper'
require "/root/protected-thicket-73961/config/initializers/devise"
require "/root/protected-thicket-73961/spec/support/factorybot"
# include Auth
# include ControllerMacros

# def log_in
#   visit new_project_path
#   click_link 'Sign up'
#   within("form") do 
#     fill_in "Email", with: "heresbobby@gmail.com"
#     fill_in "Password", with: "abcdefg"
#     fill_in "Password confirmation", with: "abcdefg"
#     click_link 'Sign up'
#   end
# end

def userlog_in
  #user = FactoryBot.create(:user)
  sign_in_user!
  visit new_project_path
end

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    userlog_in
    before(:each) do
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end