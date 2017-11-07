class NavigationType
  GUIDANCE_SCHEMAS =
    %w{answer contact guide detailed_guide document_collection publication}.freeze

  def initialize(content_item)
    @content_item = content_item
  end

  # Universal navigation:
  # https://gov-uk.atlassian.net/wiki/spaces/GFED/pages/186351726/Sprint+1+designs
  def should_present_universal_navigation?
    # TODO: Also check for test variant
    # content_is_tagged_to_a_taxon? && content_schema_is_guidance?
    # in the AB test "content navigation"
    # not in the "original" variant
    true
  end

  def universal_navigation_without_nav?
    ## should_present_universal_navigation? && UniversalNoNav test variant
    true
  end

  def universal_navigation_with_taxonomy_nav?
    ## should_present_universal_navigation? && UniversalTaxonNav test variant
    false
  end

  def universal_navigation_with_mainstream_nav?
    ## should_present_universal_navigation? && UniversalMainstreamNav test variant
    false
  end

  def should_present_taxonomy_navigation?
    tagged_to_world_wide_taxonomy? ||
      (!content_is_tagged_to_browse_pages? &&
      content_is_tagged_to_a_taxon? &&
      content_schema_is_guidance?)
  end

private

  def tagged_to_world_wide_taxonomy?
    @content_item.dig("links", "taxons").to_a.any? do |content_item|
      content_item.fetch("base_path").starts_with?("/world")
    end
  end

  def content_is_tagged_to_a_taxon?
    @content_item.dig("links", "taxons").present?
  end

  def content_is_tagged_to_browse_pages?
    @content_item.dig("links", "mainstream_browse_pages").present?
  end

  def content_schema_is_guidance?
    GUIDANCE_SCHEMAS.include? @content_item["schema_name"]
  end
end
