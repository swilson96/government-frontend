module ContentsList
  include ActionView::Helpers::UrlHelper

  def contents
    maxLevel = contents_items.max_by{|k, v| v}[:level]
    contents_items.map do |item|
      {
        text: item[:text],
        href: "##{item[:id]}",
        level: maxLevel > 1 ? 1 : item[:level]
      }
    end
  end

  def contents_items
    extract_headings_with_ids(body)
  end

private

  def extract_headings_with_ids(html)
    headings = Nokogiri::HTML(html).css('h2, h3').map do |heading|
      id = heading.attribute('id')
      level = heading.name.gsub('h', '').to_i - 1 || 1
      # We should look into if we need to nest lists based on hierachy
      { text: strip_trailing_colons(heading.text), id: id.value, level: level } if id
    end
    headings.compact
  end

  def strip_trailing_colons(heading)
    heading.gsub(/\:$/, '')
  end
end
