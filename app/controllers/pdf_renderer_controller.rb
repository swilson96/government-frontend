require 'gds_api/content_store'

class PdfRendererController < ApplicationController
  rescue_from GdsApi::HTTPNotFound, with: :error_notfound

  def show
    base_path = '/' + params[:path]
    filename = base_path.split('/').last
    send_data(render_pdf, filename: "#{filename}.pdf")
  end

  def content_store
    @content_store ||= GdsApi::ContentStore.new(Plek.current.find('content-store'))
  end

  def render_pdf
    url = Plek.find('government-frontend') + '/' + params[:path]
    html = open(url).read
    pdf_kit = PDFKit.new(html, viewport_size: '1280x1024', page_size: 'A4')

    pdf_io = StringIO.new
    pdf_io.write(pdf_kit.to_pdf)
    pdf_io.rewind
    pdf_io.read
  end

  def error_notfound
    render plain: 'Not found', status: :not_found
  end
end