class NewsArticlePresenter < ContentItemPresenter
  include Body
  include Political
  include Linkable
  include Updatable
  include Shareable
  include TitleAndContext
  include Metadata

  def image
    content_item["details"]["image"]
  end

  def published
    "<time itemprop='datePublished'>#{super}</time>"
  end

  def updated
    "<time itemprop='dateModified'>#{super}</time>"
  end

  def from
    "<meta itemprop='name'>#{super}</meta>"
  end

  def title
    "<meta itemprop='headline'>#{super}</meta>"
  end

  def description
    "<meta itemprop='description'>#{super}</meta>"
  end

  def body
    "<meta itemprop='articleBody'>#{super}</meta>"
  end
end
