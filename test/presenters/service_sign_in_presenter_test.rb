require 'presenter_test_helper'

class ServiceSignInPresenterTest
  class PresentedServiceSignIn < PresenterTestCase
    def schema_name
      "service_sign_in"
    end

    test 'presents the schema_name' do
      assert_equal schema_item['schema_name'], presented_item.schema_name
    end
  end
end
