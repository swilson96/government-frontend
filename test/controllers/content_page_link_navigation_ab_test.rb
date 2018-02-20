require 'test_helper'

class ContentItemsControllerTest < ActionController::TestCase
  include GdsApi::TestHelpers::ContentStore
  include GovukAbTesting::MinitestHelpers

  %w(A B C).each do |test_variant|
    test "link navigation multivariate test variant #{test_variant} only applies to included pages" do
      # this single page guide is not one of the test pages
      content_item = content_store_has_schema_example("guide", "single-page-guide")
      content_store_has_item(content_item["base_path"], content_item)
      path = content_item["base_path"].split("/").last

      setup_ab_variant("ContentPageLinkNavigation", test_variant)

      get :show, params: { path: path }

      assert_response_not_modified_for_ab_test("ContentPageLinkNavigation")
    end
  end
end
