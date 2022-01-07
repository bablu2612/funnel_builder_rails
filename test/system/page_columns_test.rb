require "application_system_test_case"

class PageColumnsTest < ApplicationSystemTestCase
  setup do
    @page_column = page_columns(:one)
  end

  test "visiting the index" do
    visit page_columns_url
    assert_selector "h1", text: "Page Columns"
  end

  test "creating a Page column" do
    visit page_columns_url
    click_on "New Page Column"

    click_on "Create Page column"

    assert_text "Page column was successfully created"
    click_on "Back"
  end

  test "updating a Page column" do
    visit page_columns_url
    click_on "Edit", match: :first

    click_on "Update Page column"

    assert_text "Page column was successfully updated"
    click_on "Back"
  end

  test "destroying a Page column" do
    visit page_columns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page column was successfully destroyed"
  end
end
