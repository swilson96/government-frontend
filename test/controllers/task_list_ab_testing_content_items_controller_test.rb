require 'test_helper'

class ContentItemsControllerTest < ActionController::TestCase
  include GdsApi::TestHelpers::ContentStore
  include GovukAbTesting::MinitestHelpers

  test "honours Tasklist AB Testing cookie" do
    schema_name = "guide"
    content_item = content_store_has_schema_example(schema_name, schema_name)
    content_item['base_path'] = "/pass-plus"

    content_store_has_item(content_item['base_path'], content_item)

    with_variant TaskListSidebar: "A" do
      get :show, params: { path: content_item['base_path'][1..-1] }
      assert_response 200
    end

    with_variant TaskListSidebar: "B" do
      get :show, params: { path: content_item['base_path']}

      assert_response 200
    end
  end
end
