require 'spec_helper'

describe Exercise do
  it { should have_valid(:name).when('squats') }
  it { should_not have_valid(:name).when(nil) }

end
