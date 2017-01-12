class EditionPresenter < ContentItemPresenter
  include Linkable
  include Political
  include Updatable
  include TitleAndContext
  include Metadata
  include NationalApplicability

  def body
    content_item["details"]["body"]
  end
end
