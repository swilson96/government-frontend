class AnswerPresenter < ContentItemPresenter
  include ContentItem::Body
  include ContentItem::LastUpdated
  include ContentItem::Linkable
end
