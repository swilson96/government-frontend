class PublicationPresenter < ContentItemPresenter
  include Metadata
  include NationalApplicability
  include Political

  def details
    content_item["details"]["body"]
  end

  def documents
    documents_list.join('')
  end

  def documents_count
    documents_list.size
  end

  def national_statistics?
    document_type === "national_statistics"
  end

private

  def documents_list
    @documents_list ||= append_pdf_link_to_html_attachments(content_item["details"]["documents"])
  end

  # TODO: Move this logic into Whitehall
  def append_pdf_link_to_html_attachments(documents_html)
    documents_html.map do |document_html|
      section = Nokogiri::HTML.fragment(document_html)
      metadata = section.css('.metadata').first
      type = metadata.css('.type').first

      if type.nil? || type.text.strip != 'HTML'
        document_html
      else
        html_attachment_path = section.css('.title a').attr('href')
        href = "#{html_attachment_path}.pdf"
        metadata.prepend_child("<a href='#{href}' class='download-pdf'>Download as PDF</a>")
        section.to_html
      end
    end
  end
end
