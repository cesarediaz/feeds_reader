require 'spec_helper'

describe Profile do

  it { should validate_presence_of(:profile_type) }
  it { should belong_to(:user) }

end
