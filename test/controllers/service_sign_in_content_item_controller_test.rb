require 'test_helper'

class ContentItemsControllerTest < ActionController::TestCase
  include GdsApi::TestHelpers::ContentStore

  test "redirects route for root service_sign_in page" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    invalid_part_path = path_for(content_item)

    stub_request(:get, %r{#{invalid_part_path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    get :show, params: { path: invalid_part_path }

    assert_response :redirect
    redirect_path = "#{content_item['base_path']}/#{content_item['details']['choose_sign_in']['slug']}"
    assert_redirected_to redirect_path
  end

  test "redirects route for leaf service_sign_in page" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    invalid_part_path = "#{path_for(content_item)}/invalid-slug"

    stub_request(:get, %r{#{invalid_part_path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    get :show, params: { path: invalid_part_path }

    assert_response :redirect
    redirect_path = "#{content_item['base_path']}/#{content_item['details']['choose_sign_in']['slug']}"
    assert_redirected_to redirect_path
  end

  test "renders choose_sign_in template for service_sign_in page" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    path = "#{path_for(content_item)}/#{content_item['details']['choose_sign_in']['slug']}"

    stub_request(:get, %r{#{path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    get :show, params: { path: path }

    assert_template :service_sign_in
  end

  test "renders create_new_account template for service_sign_in page" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    path = "#{path_for(content_item)}/#{content_item['details']['create_new_account']['slug']}"

    stub_request(:get, %r{#{path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    get :show, params: { path: path }

    assert_template :service_sign_in
  end



  test "service_sign_in_options with option param set" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    path = "#{path_for(content_item)}/#{content_item['details']['choose_sign_in']['slug']}"

    option = content_item['details']['choose_sign_in']['options'][0]
    value = option['text'].parameterize
    link = option['url']

    stub_request(:get, %r{#{path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    post :service_sign_in_options, params: { path: path, option: value }

    assert_response :redirect
    assert_redirected_to link
  end

  test "service_sign_in_options with no option param set displays choose_sign_in page with error" do
    content_item = content_store_has_schema_example("service_sign_in", "service_sign_in")
    path = "#{path_for(content_item)}/#{content_item['details']['choose_sign_in']['slug']}"

    stub_request(:get, %r{#{path}}).to_return(status: 200, body: content_item.to_json, headers: {})

    post :service_sign_in_options, params: { path: path }

    assert_not_nil @controller.instance_variable_get(:@error)
    assert_template :service_sign_in
  end

  def path_for(content_item, locale = nil)
    base_path = content_item['base_path'].sub(/^\//, '')
    base_path.gsub!(/\.#{locale}$/, '') if locale
    base_path
  end
end
