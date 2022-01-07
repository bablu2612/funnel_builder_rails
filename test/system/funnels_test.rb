require "application_system_test_case"

class FunnelsTest < ApplicationSystemTestCase
  setup do
    @funnel = funnels(:one)
  end

  test "visiting the index" do
    visit funnels_url
    assert_selector "h1", text: "Funnels"
  end

  test "creating a Funnel" do
    visit funnels_url
    click_on "New Funnel"

    fill_in "Name", with: @funnel.name
    click_on "Create Funnel"

    assert_text "Funnel was successfully created"
    click_on "Back"
  end

  test "updating a Funnel" do
    visit funnels_url
    click_on "Edit", match: :first

    fill_in "Name", with: @funnel.name
    click_on "Update Funnel"

    assert_text "Funnel was successfully updated"
    click_on "Back"
  end

  test "destroying a Funnel" do
    visit funnels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Funnel was successfully destroyed"
  end
end
