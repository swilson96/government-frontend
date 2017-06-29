require 'test_helper'

class AnswerTest < ActionDispatch::IntegrationTest
  # test "renders title and body" do
  #   setup_and_visit_content_item('answer')
  #   assert page.has_text?(@content_item["title"])
  #   assert_has_component_govspeak(@content_item["details"]["body"])
  #   # assert page.has_text?("Diweddarwyd diwethaf: 28 Mai 2015")
  # end

  test "related links are rendered" do
    setup_and_visit_content_item('answer')

    within page.find(".govuk-related-items") do
      elsewhere = @content_item["details"]["external_related_links"].first

      link = page.find("a")

      assert_equal elsewhere["title"], link.text
      assert_equal elsewhere["url"], link[:href]
    end
  end
end
