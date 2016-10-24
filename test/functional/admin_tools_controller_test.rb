require File.expand_path('../../test_helper', __FILE__)

class AdminToolsControllerTest < ActionController::TestCase
  tests AdminToolsController
  fixtures :users 
  
  setup do
    session[:user_id] = 1
  end
  
  test 'should render show_config' do
	get :show_config
    assert_response :success	
	
    Setting.all.each do |setting|
	  assert_select 'label', {:text=>"Name: #{setting.name}"}
    end
  end

end
