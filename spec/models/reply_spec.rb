require 'spec_helper'

describe Reply do
  before(:each) do
    @topic = Factory(:topic)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @topic.replies.create!(@attr)
  end

  describe "validations" do
    it "should require a topic id" do
      Reply.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @topic.replies.build(:content => "  ").should_not be_valid
    end
  end

  describe "topic associations" do
    before(:each) do
      @reply = @topic.replies.create(@attr)
    end

    it "should have a topic attribute" do
      @reply.should respond_to(:topic)
    end

    it "should have the right associated topic" do
      @reply.topic_id.should == @topic.id
      @reply.topic.should == @topic
    end
  end
end
