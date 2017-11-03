module ApplicationHelper
  def page_text_direction
    I18n.t("i18n.direction", locale: I18n.locale, default: "ltr")
  end

  def wrapper_class
    classes = []
    classes << "direction-#{page_text_direction}" if page_text_direction
    classes << "variant-#{navigation_variation}" if navigation_variation

    classes.join(' ')
  end

  def navigation_variation
    request.variant.any? && request.variant.first.to_s.dasherize
  end

  def universal_navigation?
    navigation_variation == 'universal-navigation'
  end

  def taxonomy_navigation?
    navigation_variation == 'taxonomy-navigation'
  end

  def active_proposition
    # Which of the government sections is the page part of?
    # Derive this from the request path, eg: /government/consultations => consultations
    active = request.original_fullpath.split('/')[2]
    active_proposition_mapping.fetch(active, active)
  end

  def current_path_without_query_string
    request.original_fullpath.split("?", 2).first
  end

private

  def active_proposition_mapping
    # Some paths don't map directly to the position nav
    # eg /government/news sits under 'announcements'
    {
      'news' => 'announcements',
      'fatalities' => 'announcements'
    }
  end
end
