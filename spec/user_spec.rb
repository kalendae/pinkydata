require 'spec_helper'

describe User, "for" do
  before(:each) do 
    @bob = User.for(:fb_sig_user => 12345, :fb_sig_session_key => 'key')
    @joe = User.for(:uid => 54321, :token => "*")
  end

  it "bob created from fb parameters should get a token" do
    @bob.token.should == "*"
  end

  it "bob should have joe as a friend" do
    @bob.friends.should satisfy{|friends| friends.any?{|f| f['name'] == 'Joe Smith'}} 
  end

  it "bob should have some interests" do
    @bob.likes.should have(4).things
  end

  it "joe should have some interests" do
    @joe.likes.should have(3).things
  end

  it "bob and joe should have 2 interests in common" do
    @bob.likes_intersecting_with(@joe).should have(2).things
  end

  it "bob should have liked Intel Extreme Masters before joe" do
    @bob.likes_before(@joe).first.name.should == "Intel Extreme Masters"
  end

  it "joe should have liked PhotoVoo! before bob" do
    @joe.likes_before(@bob).first.name.should == "PhotoVoo!"
  end

end

