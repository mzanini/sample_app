require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	test "If passwords do not match user is not added" do
		get signup_path
		assert_no_difference 'User.count' do 
			post users_path, user:{ name: "", email: "user@invalid.com", password:"foo", password_confirmation: "bar" }
		end
		assert_template 'users/new'
		assert_select 'div[id=error_explanation]'
		assert_select 'div[class="alert alert-danger"]'
	end

	test "if valid signup information user is registered" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user:{ name: "Marco", email: "user@invalid.com", password:"foobar", password_confirmation: "foobar" }
		end
		assert_template 'users/show'
		assert_not flash.empty?
		assert is_logged_in?
	end
end
