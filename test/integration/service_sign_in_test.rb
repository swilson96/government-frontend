require 'test_helper'

class ServiceSignInTest < ActionDispatch::IntegrationTest
  test "random but valid items do not error" do
    setup_and_visit_random_content_item
  end

  test "page renders correctly" do
    setup_and_visit_content_item('service_sign_in')

    assert page.has_css?("title", text: "Prove your identity to continue - GOV.UK")
    assert page.has_css?('meta[name="robots"][content="noindex, nofollow"]', visible: false)
    refute page.has_css?(shared_component_selector('breadcrumbs'))
    refute page.has_css?(shared_component_selector('government_navigation'))

    within "form" do
      within ".app-c-fieldset" do
        within ".app-c-fieldset__legend" do
          within shared_component_selector('title') do
            assert page.has_text?("Prove your identity to continue")
          end
        end

        within shared_component_selector('govspeak') do
          assert page.has_text?("You can't file online until you've activated Government Gateway account using your Unique Taxpayer Reference(UTR).")
        end

        within ".app-c-radio:first-of-type" do
          assert page.has_css?(".app-c-radio__label__text", text: "Use Government Gateway")
          assert page.has_css?(".app-c-radio__label__hint", text: "You'll have a user ID if you've registered to file your Self Assessment tax return online before.")
        end

        within ".app-c-radio:nth-of-type(2)" do
          assert page.has_css?(".app-c-radio__label__text", text: "Use GOV.UK Verify")
          assert page.has_css?(".app-c-radio__label__hint", text: "You'll have an account if you've proved your identity with a certified company, such as the Post Office.")
        end

        within ".app-c-radio:last-of-type" do
          assert page.has_css?(".app-c-radio__label__text", text: "Create an account")
        end
      end
      assert page.has_css?(shared_component_selector('button'), text: "Continue")
    end
  end
end
