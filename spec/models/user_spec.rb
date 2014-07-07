require 'rails_helper'

RSpec.describe User, :type => :model do
  let :user do
    build :user
  end

  subject do
   user
  end
  
  context 'is invalid' do
    it 'when required #email is not given' do
      user.email = ''
      should_not be_valid
    end

    it 'when required #password is not given' do
      user.password = nil
      should_not be_valid
    end

    it 'when required #full_name is not given' do
      user.full_name = ''
      should_not be_valid
    end
    
    it 'when #email is not unique' do
      user.save
      user1 = build :user
      user1.save

      user1.should_not be_valid
      user1.errors.full_messages[0].should match 'Email has already been taken'
    end
    
    it 'when #email format is not valid' do
      user.email = 'invalid email address'
      should_not be_valid
    end
    
    it 'when #password is not at least 8 characters' do
      user.password = 'abc123'
      should_not be_valid
    end
    
    it 'is valid' do
      should be_valid
    end
    
  end
  
end