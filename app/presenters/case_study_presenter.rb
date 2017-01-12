class CaseStudyPresenter < EditionPresenter
  def image
    content_item["details"]["image"]
  end
end
