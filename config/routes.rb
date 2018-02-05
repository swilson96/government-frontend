Rails.application.routes.draw do
  unless Rails.env.production?
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
    get 'random/:schema' => 'randomly_generated_content_item#show'
  end

  root to: 'development#index'

  mount GovukPublishingComponents::Engine, at: "/component-guide"

  # Place pages
  constraints FormatRoutingConstraint.new('place') do
    get ":slug", to: "place#show"
    post ":slug", to: "place#show" # Support for postcode submission which we treat as confidential data
    get ":slug/:part", to: redirect('/%{slug}') # Support for places that were once a format with parts
  end

  get 'healthcheck', to: proc { [200, {}, ['']] }

  get '*path/:variant' => 'content_items#show',
      constraints: {
        variant: /print/
      }

  get '*path(.:locale)(.:format)' => 'content_items#show',
      constraints: {
        format: /atom/,
        locale: /\w{2}(-[\d\w]{2,3})?/,
      }

  post '*path' => 'content_items#service_sign_in_options'
end
