require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    #create initial example
    let(:user) {User.new(first_name: 'Declan', last_name: "O'Donnell", email: 'example@test.com', password: 'password', password_confirmation: 'password')}
    let(:user2) {User.new(first_name: 'David', last_name: 'Bowie', email: 'EXAMPLE@TEST.com', password: 'password', password_confirmation: 'password')}
    let(:user3) {User.new(first_name: 'Dave', last_name: 'Grohl', email: 'test2@test.com', password: 'hello', password_confirmation: 'h3llo')}
    context 'when all the proper attributes are provided' do
      it 'should be valid' do
        user.valid?
        expect(user).to be_valid
    # validation tests/examples here
      end
    end
    context 'when first name is not present' do
      it 'should not be valid' do
        user.first_name = nil
        expect(user).to_not be_valid
      end
      it 'reports a validation error when first name blank' do
        user.first_name = nil
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end
    end
    context 'when last name is not present' do
      it 'should not be valid' do
        user.last_name = nil
        expect(user).to_not be_valid
      end
      it 'reports a validation error when last name blank' do
        user.last_name = nil
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end
    context 'when password is not present' do
      it 'should not be valid' do
        user.password = nil
        expect(user).to_not be_valid
      end
      it 'reports a validation error when password blank' do
        user.password = nil
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
    end
    context 'when password confirmation is not present' do
      it 'should not be valid' do
        user.password_confirmation = ''
        expect(user).to_not be_valid
      end
      it 'reports a validation error when password confirmation blank' do
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context 'when password does not match password confirmation' do
      it 'should not be valid' do
        user.password = 'peacan'
        user.valid?
        expect(user).to_not match(user.password_confirmation)
      end
      it 'reports a validation error on the password matching' do
        user.password = 'pa55w0rd'
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context 'when a duplicate email is provided' do
      it 'should not be valid' do 
        user.save
        expect(user2).to_not be_valid
      end
      it 'reports a validation error on the email' do
        user.save
        user2.valid?
        expect(user2.errors.full_messages).to include "Email has already been taken"
      end
    end
    context 'when a password is not long enough' do
      it 'should not be valid' do 
        expect(user3).to_not be_valid
      end
      it 'reports a validation error on the email' do
        user3.valid?
        expect(user3.errors.full_messages).to include "Password is too short (minimum is 8 characters)"
      end
    end
  end
  describe '.authenticate_with_credentials' do
    let(:user4) {User.create(first_name: 'John', last_name: 'Doe', email: 'example@test.com', password: 'password', password_confirmation: 'password')}
    context 'when email and password match' do
      it 'should be valid' do
        valid_user = User.authenticate_with_credentials('example@test.com', 'password')
        expect(valid_user).to eq(@user4)
      end
    end
    context 'when email does not match' do
      it 'should return nil' do
        user = User.authenticate_with_credentials('testing@test.com', 'password')
        expect(user).to eq(nil)
      end
    end
    context 'when password does not match records' do
      it 'should return nil' do
        user = User.authenticate_with_credentials('example@test.com', 'Notthepassword')
        expect(user).to eq(nil)
      end
    end
    context 'when password or email has whitespace' do
      it 'should be valid' do
        valid_user = User.authenticate_with_credentials('   example@test.com ', '  password  ')
        expect(valid_user).to eq(@user4)
      end
    end
    context 'when email has caps' do
      it 'should be valid' do
        valid_user = User.authenticate_with_credentials('TEST@tESt.cOm', 'password')
        expect(valid_user).to eq(@user4)
      end
    end
  end
end