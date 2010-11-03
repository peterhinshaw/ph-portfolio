Feature: Folder Listing
As a user
I want to see folders containing photo files
So that I can find my photo files

Scenario: List a folder with at least one jpg image file
Given I have jpg files save in a folder named (.+)
When I fileseek
Then the folder name "xxxx" should be displayed 
