require 'spec_helper'

describe Channel do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }

end
