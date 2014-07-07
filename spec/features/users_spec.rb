require 'rails_helper'

RSpec.describe "Users", :type => :feature do
  
  context 'GET /users/new' do
    it 'displays the create new user page' do
      visit new_user_path
                      
      page.should have_content 'Email'
      page.should have_content 'Full Name'
      page.should have_content 'Password'
      page.should have_content 'Confirm Password'
      page.has_field? 'email'
      page.has_field? 'full_name'
      page.has_field? 'password'
      page.has_field? 'password_confirmation'
      page.has_button? 'Sign Up'
    end
  end
  
  context 'GET /signup' do
    it 'displays the sign up page' do
      visit signup_path

      page.should have_content 'Email'
      page.should have_content 'Full Name'
      page.should have_content 'Password'
      page.should have_content 'Confirm Password'
      page.has_field? 'email'
      page.has_field? 'full_name'
      page.has_field? 'password'
      page.has_field? 'password_confirmation'
      page.has_button? 'Sign Up'
    end
  end

  context 'POST /users' do
    it 'creates and saves the valid user' do
      visit new_user_path

      fill_in 'Email', with: 'mail2gok@gmail.com'
      fill_in 'Password', with: 'password123', match: :prefer_exact
      fill_in 'Confirm Password', with: 'password123', match: :prefer_exact
      fill_in 'Full Name', with: 'Gokulamurthy P'
      click_button 'Sign Up'

      current_path.should == signup_path
      page.should have_content 'The User is successfully saved!'
    end
  end

  context 'not saving invalid user' do
    it 'when passwords mismatch' do
      visit new_user_path

      fill_in 'Email', with: 'mail2gok@gmail.com'
      fill_in 'Password', with: 'password123', match: :prefer_exact
      fill_in 'Confirm Password', with: 'wrong-password', match: :prefer_exact
      fill_in 'Full Name', with: 'Gokulamurthy P'
      click_button 'Sign Up'

      current_path.should == signup_path
      page.should have_content "Password doesn't match confirmation"
    end
  end

  it 'when email is blank' do
    visit new_user_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password123', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password123', match: :prefer_exact
    fill_in 'Full Name', with: 'Gokulamurthy P'
    click_button 'Sign Up'

    current_path.should == signup_path
    page.should have_content "Email can't be blank"
  end

  it 'when password is blank' do
    visit new_user_path

    fill_in 'Email', with: 'mail2gok@gmail.com'
    fill_in 'Password', with: nil, match: :prefer_exact
    fill_in 'Confirm Password', with: nil, match: :prefer_exact
    fill_in 'Full Name', with: 'Gokulamurthy P'
    click_button 'Sign Up'

    current_path.should == signup_path
    page.should have_content "Password can't be blank"
  end

  it 'when full name is blank' do
    visit new_user_path

    fill_in 'Email', with: 'mail2gok@gmail.com'
    fill_in 'Password', with: 'password123', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password123', match: :prefer_exact
    fill_in 'Full Name', with: ''
    click_button 'Sign Up'

    current_path.should == signup_path
    page.should have_content "Full name can't be blank"
  end
  
  it 'when email is not unique' do
    create :user
    visit new_user_path

    fill_in 'Email', with: 'mail2gok@gmail.com'
    fill_in 'Password', with: 'password123', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password123', match: :prefer_exact
    fill_in 'Full Name', with: 'Gokulamurthy P'
    click_button 'Sign Up'

    current_path.should == signup_path
    page.should have_content 'Email has already been taken'
  end
  
  it 'when password is less than 8 characters' do
    visit new_user_path

    fill_in 'Email', with: 'mail2gok@gmail.com'
    fill_in 'Password', with: 'password123', match: :prefer_exact
    fill_in 'Confirm Password', with: 'password123', match: :prefer_exact
    fill_in 'Full Name', with: 'Gokulamurthy P'
    click_button 'Sign Up'

    current_path.should == signup_path
    page.should have_content "Password is too short (minimum is 8 characters)"
  end

  context 'PUT users/:id' do
    it 'valid user update' do
      user = create :user
      visit edit_user_path user

      find_field('Email').value.should == 'mail2gok@gmail.com'
      find_field('Full Name').value.should == 'Gokulamurthy P'

      fill_in 'Email', with: 'mail2gok@gmail.com'
      fill_in 'Password', with: 'newpassword123'
      fill_in 'Confirm Password', with: 'newpassword123'
      fill_in 'Full Name', with: 'Gokulamurthy Purushothaman'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      page.should have_content 'The User is successfully updated!'
    end
    
    it 'invalid when passwords mismatch' do
      user = create :user
      visit edit_user_path user

      fill_in 'Email', with: 'mail2gok@gmail.com'
      fill_in 'Password', with: 'newpassword123'
      fill_in 'Confirm Password', with: 'newpassword'
      fill_in 'Full Name', with: 'Gokulamurthy P'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      page.should have_content "Password doesn't match confirmation"
    end
    
    it 'keeps the User Email intact while other fields do change' do
      user = create :user
      visit edit_user_path user

      find_field('Email').value.should == 'mail2gok@gmail.com'
      find_field('Full Name').value.should == 'Gokulamurthy P'

      fill_in 'Email', with: 'dummy-account@gmail.com'
      fill_in 'Password', with: 'newpassword123'
      fill_in 'Confirm Password', with: 'newpassword123'
      fill_in 'Full Name', with: 'Gokulamurthy Purushothaman'
      click_button 'Update User'

      current_path.should == edit_user_path(user)
      find_field('Email').value.should == 'mail2gok@gmail.com'
      find_field('Full Name').value.should == 'Gokulamurthy Purushothaman'
    end
    
  end

end