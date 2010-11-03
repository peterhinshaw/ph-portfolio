Given /^user is verified$/ do
  pending
end
Then /^the user "(.+)" can log in with password "(.+)"$/ do |username, password| 
  visit login_path 
  fill_in "login", :with => username 
  fill_in "password", :with => password 
  click_button "Log In" 
  response.should contain("Logged in Successfully") 
end

Given /^(?:|I )have jpg files save in a folder named (.+)$/ do |folder| 
  Dir[(folder)/"*jpg"].exists?
end

When /^I fileseek$/ do
  visit fileseek_path
end

Then /^the folder name "xxxx" should be displayed$/ do |folder|
  response.should contain(folder) 
end

