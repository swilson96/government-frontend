require 'test_helper'

class StatisticsAnnouncementTest < ActionDispatch::IntegrationTest
  test "official statistics" do
    setup_and_visit_content_item('official_statistics')

    assert_has_component_title(@content_item["title"])
    assert page.has_text?(@content_item["description"])

    assert_has_important_metadata("Release date": "20 January 2016 9:30am (confirmed)")
    assert_has_link_to_finder(
      "More statistics announcements about National Health Service from NHS England",
      "/government/statistics/announcements",
      "departments[]" => "nhs-commissioning-board",
      "topics[]" => "national-health-service"
    )
  end

  test "national statistics" do
    setup_and_visit_content_item('national_statistics')

    assert_has_component_title(@content_item["title"])
    assert page.has_text?(@content_item["description"])
    assert page.has_css?('img[alt="National Statistics"]')

    within '.app-c-important-metadata' do
      assert page.has_text?("Release date: January 2016 (provisional)")
    end
  end

  test "cancelled statistics" do
    setup_and_visit_content_item('cancelled_official_statistics')

    assert_has_component_title(@content_item["title"])
    assert page.has_text?(@content_item["description"])
    within '.app-c-notice' do
      assert page.has_text?('Statistics release cancelled'), "is cancelled"
      assert page.has_text?(@content_item["details"]["cancellation_reason"]), "displays cancelleation reason"
    end

    assert_has_important_metadata(
      "Proposed release": "20 January 2016 9:30am",
      "Cancellation date": "17 January 2016 2:19pm"
    )
  end

  test "statistics with a changed release date" do
    setup_and_visit_content_item('release_date_changed')

    assert_has_component_title(@content_item["title"])
    assert page.has_text?(@content_item["description"])
    assert page.has_text?("Release date: 20 January 2016 9:30am (confirmed)")

    within '.release-date-changed .app-c-important-metadata' do
      assert page.has_text?("The release date has been changed")
      assert page.has_text?("Previous date")
      assert page.has_text?("19 January 2016 9:30am")
      assert page.has_text?("Reason for change")
      assert page.has_text?(@content_item["details"]["latest_change_note"])
    end
  end

  test "statistics announcement that are not cancelled display forthcoming notice" do
    setup_and_visit_content_item('official_statistics')

    within(".app-c-notice") do
      assert_text "#{StatisticsAnnouncementPresenter::FORTHCOMING_NOTICE} on #{@content_item['details']['display_date']}"
    end
  end

  test "cancelled statistics announcements do not display the forthcoming notice" do
    setup_and_visit_content_item('cancelled_official_statistics')

    refute page.has_text?(StatisticsAnnouncementPresenter::FORTHCOMING_NOTICE)
  end
end
