class StatisticalDataSetPresenter < EditionPresenter
  include ExtractsHeadings
  include ActionView::Helpers::UrlHelper

  def contents
    extract_headings_with_ids(body).map do |heading|
      link_to(heading[:text], "##{heading[:id]}")
    end
  end
end
