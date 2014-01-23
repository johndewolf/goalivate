require 'spec_helper'

describe User do
  it { should have_valid(:first_name).when('Jack', 'John') }
  it { should_not have_valid(:first_name).when(nil) }

  it { should have_valid(:last_name).when('Dee') }
  it { should_not have_valid(:last_name).when(nil) }

  it { should have_valid(:email).when('jd@aol.com') }
  it { should_not have_valid(:email).when('', 'jdaol.com', 'jd@aolcom', '@aol.com') }

  it { should have_many(:goals) }

  it "does not have matching password confirmation for the password" do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'passowrd'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
