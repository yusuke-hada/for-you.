require 'test_helper'

class AnniversariesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get anniversaries_index_url
    assert_response :success
  end

  test 'should get new' do
    get anniversaries_new_url
    assert_response :success
  end

  test 'should get create' do
    get anniversaries_create_url
    assert_response :success
  end

  test 'should get show' do
    get anniversaries_show_url
    assert_response :success
  end

  test 'should get edit' do
    get anniversaries_edit_url
    assert_response :success
  end

  test 'should get update' do
    get anniversaries_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get anniversaries_destroy_url
    assert_response :success
  end
end
