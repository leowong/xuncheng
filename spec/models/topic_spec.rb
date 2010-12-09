require 'spec_helper'

describe Topic do
  before(:each) do
    @attr = {
      :title => "value for title",
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    Topic.create!(@attr)
  end

  describe "validations" do
    it "should require a topic title" do
      Topic.new(@attr.merge(:title => "")).should_not be_valid
    end

    it "should require nonblank content" do
      Topic.new(@attr.merge(:content => "")).should_not be_valid
    end
  end

  describe "reply associatoins" do
    before(:each) do
      @topic = Topic.create(@attr)
      @reply = Factory(:reply, :topic => @topic)
    end

    it "should have a replies attribute" do
      @topic.should respond_to(:replies)
    end

    it "should destroy associated microposts" do
      @topic.destroy
      Reply.find_by_id(@reply.id).should be_nil
    end
  end
end
