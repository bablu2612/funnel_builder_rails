require 'test_helper'

class PageColumnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_column = page_columns(:one)
  end

  test "should get index" do
    get page_columns_url
    assert_response :success
  end

  test "should get new" do
    get new_page_column_url
    assert_response :success
  end

  test "should create page_column" do
    assert_difference('PageColumn.count') do
      post page_columns_url, params: { page_column: {  } }
    end

    assert_redirected_to page_column_url(PageColumn.last)
  end

  test "should show page_column" do
    get page_column_url(@page_column)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_column_url(@page_column)
    assert_response :success
  end

  test "should update page_column" do
    patch page_column_url(@page_column), params: { page_column: {  } }
    assert_redirected_to page_column_url(@page_column)
  end

  test "should destroy page_column" do
    assert_difference('PageColumn.count', -1) do
      delete page_column_url(@page_column)
    end

    assert_redirected_to page_columns_url
  end
end
