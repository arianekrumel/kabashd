require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get games" do
    get :games
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

end
