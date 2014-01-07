require 'spec_helper'

describe ContactInquiry do
  it { should have_valid(:first_name).when('User') }
  it { should_not have_valid(:first_name).when('') }

  it { should have_valid(:last_name).when('Anon') }
  it { should_not have_valid(:last_name).when('', nil) }

  it { should have_valid(:email).when('anonuser@gmail') }
  it { should_not have_valid(:email).when('', nil, 'thisemailaddressiswaytoomanycharacters@gmail.com') }

  it { should have_valid(:subject).when('your site is awesome') }
  it { should_not have_valid(:subject).when('', nil) }

  it { should have_valid(:content).when('thanks for making it') }
  it { should_not have_valid(:content).when('', nil) }
end
