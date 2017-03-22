require 'test_helper'

class HelpPageTest < ActionDispatch::IntegrationTest
  test "renders title, description and body" do
    setup_and_visit_content_item('help_page')
    assert page.has_text?(@content_item["title"])
    assert_has_component_govspeak(@content_item["details"]["body"].squish)
  end
end
