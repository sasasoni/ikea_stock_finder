require 'test_helper'

class GetStocksTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "search with succeed" do
    correct_product_number = "10373589" #IKEAのサメ
    get search_path, params: { q_product: correct_product_number }
    assert_template 'static_pages/home'
    assert flash.empty?
  end

  test "search with not found" do
    incorrect_product_numbers = %w(12345678 123 abc 12ab) #不正な値
    incorrect_product_numbers.each do |incorrect_number|
      get search_path, params: { q_product: incorrect_number }
      assert_redirected_to root_url
      follow_redirect!
      assert_template 'static_pages/home'
      assert_not flash.empty?
      end
  end
end
