require "spec_helper"

describe 'Print Link' do
  it 'renders default' do
    visit '/component-guide/print-link/default'
    preview_html = page.find('.component-guide-preview')['innerHTML']
    within '.component-guide-preview' do
      expect(page).to have_css(
        ".app-c-print-link .app-c-print-link__link[href=\"/print-this\"]",
        text: "Print entire guide"
      ), "could not find that, but the preview contains #{preview_html}"
    end
    expect(page).to be_accessible.within '.component-guide-preview'
  end


  it 'renders custom link text' do
    visit '/component-guide/print-link/custom_link_text'
    preview_html = page.find('.component-guide-preview')['innerHTML']
    within '.component-guide-preview' do
      expect(page).to have_css(
        ".app-c-print-link .app-c-print-link__link[href=\"/print-me\"]",
        text: "Print me"
      ), "could not find that, but the preview contains #{preview_html}"
    end
    expect(page).to be_accessible.within '.component-guide-preview'
  end
end
