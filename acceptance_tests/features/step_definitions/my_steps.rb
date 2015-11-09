Given(/^I am on the start page for the form$/) do
  visit config['example_app_host']
end

Then(/^I can see the questions for the first page of the form$/) do
  expect(page).to have_content 'Step 1 of '
  expect(page).to have_content 'Example radio buttons'
  expect(page).to have_content 'Example date group'
  expect(page).to have_content 'Example text input'
  expect(page).to have_content 'Example text input with validation for email address'
  expect(page).to have_content 'Example checkbox'
end

When(/^I complete the first page of the form incorrectly$/) do
  fill_in "example-dob-day", :with => 'ff'
  fill_in "example-dob-month", :with => 'ff'
  fill_in "example-dob-year", :with => 'ff'
  fill_in "example-email", :with => 'notvalid'
  click_button("Continue")
end

Then(/^I am presented with validation errors for the first page$/) do
  expect(page).to have_content 'Tell us which is your favourite superhero'
  expect(page).to have_content 'Date must only contain numbers'
  expect(page).to have_content 'Enter your favourite colour'
  expect(page).to have_content 'The email address isn\'t valid, enter a valid email address'
end

When(/^I complete the first page of the form correctly$/) do
  find_by_id('example-radio-superman').click
  fill_in "example-dob-day", :with => '10'
  fill_in "example-dob-month", :with => '10'
  fill_in "example-dob-year", :with => '1980'
  fill_in "example-email", :with => 'valid@valid.woohoo'
  fill_in "example-text", :with => 'Brown'
  click_button("Continue")
end

Then(/^I am taken to the second page of the form$/) do
  expect(page).to have_content 'These radio buttons toggle a hidden field'
  expect(page).to have_no_content 'This is a hidden field, toggled by the above radio buttons'
end

When(/^I select yes on the radio button$/) do
  find_by_id('yes-no-radio-toggler-Yes').click
end

Then(/^I can see another field appear$/) do
  expect(page).to have_content 'You showed me!!'
end

When(/^I select no on the radio button$/) do
  find_by_id('yes-no-radio-toggler-No').click
end

Then(/^the hidden field disappears again$/) do
  expect(page).to have_no_content 'You showed me!!'
end

When(/^I click continue$/) do
  click_button("Continue")
end

Then(/^I am taken to the third page of the form$/) do
  expect(page).to have_content 'This page shows how to make a field mandatory depending on the answer to a previous question'
end

When(/^I select the yes radio button$/) do
  find_by_id('yes-no-radio-Yes').click
end

Then(/^I am presented with an error for the field that is dependent on Yes being selected$/) do
  expect(page).to have_content 'Input the name of your pet dog'
end

When(/^I select the no radio button$/) do
  find_by_id('yes-no-radio-No').click
end

Then(/^I am taken to the fourth page$/) do
  expect(page).to have_content 'This page demonstrates custom validation'
end