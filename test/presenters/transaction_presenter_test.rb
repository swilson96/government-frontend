require 'presenter_test_helper'

class TransactionPresenterTest
  class PresentedTransaction < PresenterTestCase
    def schema_name
      "transaction"
    end

    test 'presents the schema_name' do
      assert_equal schema_item['schema_name'], presented_item.schema_name
    end
  end
end
