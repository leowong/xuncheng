require 'spec_helper'

describe Topic do
  before(:each) do
    @topic = Topic.new
  end

  it "should be valid" do
    @topic.should be_valid
  end
end
