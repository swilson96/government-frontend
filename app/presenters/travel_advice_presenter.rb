class TravelAdvicePresenter < ContentItemPresenter
  include ActionView::Helpers::UrlHelper

  def initialize(content_item, params)
    super(content_item, params)
    add_meta
  end

  def details
    content_item["details"]
  end

  def add_meta
    subsections.each do |subsection|
      link = content_item["base_path"] + "/" + subsection["slug"]
      subsection["link"] = link
      subsection["current_section"] = @params[:section] == subsection["slug"]
    end
  end

  def country
    content_item["details"]["country"]["name"]
  end

  def reviewed_at
    details['reviewed_at']
  end

  def is_section?
    section_name.present?
  end

  def section_name
    @params[:section]
  end

  def section_title
    false
  end


  def retrieve_section(section)
    content_item["details"]["parts"].select { |sec| sec["slug"] == section }.first
  end

  def subsections
    content_item["details"]["parts"]
  end


  def body
    if is_section?
      retrieve_section(section_name)["body"]
    else
      content_item["details"]["summary"]
    end
  end

  def last_reviewed_or_updated_at
    if reviewed_at
      Date.parse(reviewed_at)
    else
      updated_at
    end
  end

  def latest_update
    content_item["details"]["change_description"]
  end

  def summary
    '<span class="part-title">
      Summary
    </span>
    <span class="part-description">
      Current travel advice
    </span>'.html_safe
  end

  def show_metadata?
    true
  end

  def additional_metadata
    {
      "Still current at" => Date.today.strftime("%e %B %Y"),
      "Updated" => content_item.last_reviewed_or_updated_at.strftime("%e %B %Y"),
      "Latest update" => simple_format(content_item.latest_update) 
    }
  end

  def show_subscriptions?
    true
  end

  # these are also hardcoded in multipage frontend
  def breadcrumbs
    [
      {
        title: "Home",
        url: "/",
      },
      {
        title: "Passports, travel and living abroad",
        url: "/browse/abroad",
      },
      {
        title:  "Travel abroad",
        url:  "/browse/abroad/travel-abroad",
      },
      {
        title:  "Foreign travel advice",
        url:  "/foreign-travel-advice",
      },
    ]
  end

  def related_links
    [
      {
        title: "Travel abroad",
        url: "/browse/abroad/travel-abroad",
        items: [
          {
            title: "Driving abroad",
            url: "/driving-abroad"
          },
          {
            title: "Hand luggage restrictions at UK airports",
            url: "/hand-luggage-restrictions",
          },
        ]
      },
      {
        title: "Passports, travel and living abroad",
        url: "/browse/abroad",
        items: [
          {
            title: "Renew or replace your adult passport",
            url: "/renew-adult-passport"
          }
        ]
      }
    ]
  end

end
