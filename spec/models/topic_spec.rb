require 'spec_helper'

describe Topic do
  before(:each) do
    @topic = Factory(:topic)
  end

  it "should be valid" do
    @topic.should be_valid
  end

  describe "validations" do
    it "should require a topic title" do
      Topic.new(:title => "", :content => @topic.title).should_not be_valid
    end

    it "should require nonblank content" do
      Topic.new(:title => @topic.title, :content => "").should_not be_valid
    end
  end
end
