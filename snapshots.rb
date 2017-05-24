require 'percy/capybara/anywhere'
require 'pry'
require 'rspec'
ENV['PERCY_DEBUG'] = '1'  # Enable debugging output.

# Configuration.
server = 'http://localhost:3090'
assets_dir = File.expand_path('../', __FILE__)
assets_base_url = '/'

Percy::Capybara::Anywhere.run(server, assets_dir, assets_base_url) do |page|
  page.visit("/cma-cases/firstgroup-and-mtr-south-western-rail-franchise-merger-inquiry")
  Percy::Capybara.snapshot(page, name: 'cma-case', widths: [375, 1280])
end
