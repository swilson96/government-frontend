class TransactionPresenter < ContentItemPresenter
  include ContentItem::LastUpdated

  def introductory_paragraph
    content_item["details"]["introductory_paragraph"]
  end

  def downtime_message
    content_item["details"]["downtime_message"]
  end

  def transaction_start_link
    content_item["details"]["transaction_start_link"]
  end

  def will_continue_on
    content_item["details"]["will_continue_on"]
  end

  def more_information
    content_item["details"]["more_information"]
  end

  def what_you_need_to_know
    content_item["details"]["what_you_need_to_know"]
  end

  def other_ways_to_apply
    content_item["details"]["other_ways_to_apply"]
  end

  def multiple_more_information_sections?
    [more_information, what_you_need_to_know, other_ways_to_apply].count(&:present?) > 1
  end

  def start_button_text
    details = content_item["details"]
    unless details && details["start_button_text"].present?
      return I18n.t("transaction.start_now")
    end

    if details["start_button_text"] == "Start now"
      I18n.t("transaction.start_now")
    elsif details["start_button_text"] == "Sign in"
      I18n.t("transaction.sign_in")
    else
      details["start_button_text"]
    end
  end
end
