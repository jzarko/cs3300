require 'rails_helper'
require_relative '../support/devise'

def sign_user_in
  visit root_path
  click_link "New Project"
  click_link "Sign up"
  within("form") do
    fill_in "Email", with: "testemail1@gmail.com"
    fill_in "Password", with: "testPassword1"
    fill_in "Password confirmation", with: "testPassword1"
    click_button "Sign up"
  end
end

def log_user_in
  visit root_path
  click_link "New Project"
  within("form") do
    fill_in "Email", with: "testemail1@gmail.com"
    fill_in "Password", with: "testPassword1"
    click_button "Log in"
  end
end

RSpec.feature "Projects", type: :feature do

  context "Sign Up" do
    scenario "should successfully sign up a user" do
      sign_user_in
      expect(page).to have_content("You have signed up successfully")
    end
  end

  context "Login" do
    scenario "should log in an existing user" do
      sign_user_in
      click_link "Back"
      click_link "Logout"
      log_user_in
      expect(page).to have_content("Signed in successfully")
    end
  end

  context "Create new project" do
    before(:each) do
      visit new_project_path
      sign_user_in
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
      sign_user_in
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
      sign_user_in
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end