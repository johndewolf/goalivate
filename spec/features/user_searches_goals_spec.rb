require 'spec_helper'

  feature 'user searchs for goal on site' do


  scenario 'user enters in search that returns results' do
    keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('body').trigger(e);"
    goal = FactoryGirl.create(:goal, title: 'write acceptance tests')
    sign_in_as(goal.user)
    fill_in 'q_title_cont', with: 'write'
    page.driver.execute_script(keypress)
    save_and_open_page

  end



end
