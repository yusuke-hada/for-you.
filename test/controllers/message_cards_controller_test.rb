require "test_helper"

class MessageCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get message_cards_index_url
    assert_response :success
  end

  test "should get new" do
    get message_cards_new_url
    assert_response :success
  end

  test "should get create" do
    get message_cards_create_url
    assert_response :success
  end

  test "should get show" do
    get message_cards_show_url
    assert_response :success
  end

  test "should get edit" do
    get message_cards_edit_url
    assert_response :success
  end

  test "should get update" do
    get message_cards_update_url
    assert_response :success
  end

  test "should get destroy" do
    get message_cards_destroy_url
    assert_response :success
  end
end
