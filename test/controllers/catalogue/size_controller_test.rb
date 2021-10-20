require "test_helper"

class Catalogue::SizeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get catalogue_size_index_url
    assert_response :success
  end

  test "should get create" do
    get catalogue_size_create_url
    assert_response :success
  end
end
