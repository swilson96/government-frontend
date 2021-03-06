class DetailedGuidePresenter < ContentItemPresenter
  include ContentItem::Body
  include ContentItem::ContentsList
  include ContentItem::Metadata
  include ContentItem::NationalApplicability
  include ContentItem::Political
  include ContentItem::TitleAndContext

  def title_and_context
    super.tap do |t|
      t[:context] = I18n.t("content_item.schema_name.guidance", count: 1)
    end
  end

  def related_navigation
    nav = super
    nav[:related_items] += related_links("related_mainstream_content")
    nav[:related_guides] = related_links("related_guides")
    nav
  end

  def logo
    image = content_item.dig("details", "image")
    return unless image
    { path: image["url"], alt_text: "European structural investment funds" }
  end

private

  def related_links(key)
    raw_links = content_item["links"]
    guides = raw_links.fetch(key, [])
    guides.map { |g| { text: g["title"], path: g["base_path"] } }
  end

  def related_guides_title
    I18n.t('detailed_guide.related_guides')
  end
end
