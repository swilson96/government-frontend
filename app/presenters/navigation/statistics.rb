module Navigation
  module Statistics
    include Finders

    def finder_path_and_params
      "/government/#{finder_path}?#{facet_params}"
    end

    def facet_params
      departments.merge(topics).to_query
    end

    def finder_path
      path = "statistics"
      path += "/announcements" if announcement?
      path
    end

    def pluralised_document_type
      return "statistics announcements" if announcement?
      doctype = I18n.t("content_item.schema_name.#{document_type}", count: 2, locale: :en)
      doctype[0] = doctype[0].downcase
      doctype
    end

    def announcement?
      schema_name == "statistics_announcement"
    end
  end
end
