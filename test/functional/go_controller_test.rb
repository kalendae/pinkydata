require 'test_helper'

class GoControllerTest < ActionController::TestCase
  test "should get choose" do
    get :choose
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
