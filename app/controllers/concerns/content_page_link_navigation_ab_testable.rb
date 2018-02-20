module ContentPageLinkNavigationAbTestable
  DIMENSION = 1000.freeze
  TEST_NAME = "ContentPageLinkNavigation".freeze
  TEST_PATHS = %w(
    /apprenticeships-guide
    /government/publications/national-curriculum-in-england-mathematics-programmes-of-study
  )

  def self.included(base)
    base.helper_method(
      :link_navigation_test_variant,
      :is_tested_content_page?,
    )

    base.after_action :set_link_navigation_test_response_header
  end

  def link_navigation_test
    @link_navigation_test ||=
      GovukAbTesting::AbTest.new(TEST_NAME,
                                 dimension: DIMENSION,
                                 allowed_variants: %w(A B C))
  end

  def link_navigation_test_variant
    @link_navigation_test_variant ||=
      link_navigation_test.requested_variant(request.headers)
  end

  def set_link_navigation_test_response_header
    link_navigation_test_variant.configure_response(response) if is_tested_content_page?
  end

  def is_tested_content_page?
    binding.pry
    TEST_PATHS.include?(content_item.base_path)
  end
end
