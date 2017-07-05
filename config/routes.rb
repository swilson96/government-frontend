Rails.application.routes.draw do
  unless Rails.env.production?
    mount GovukPublishingComponents::Engine, at: "/component-guide"
    mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
    get 'random/:schema' => 'randomly_generated_content_item#show'
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
end
