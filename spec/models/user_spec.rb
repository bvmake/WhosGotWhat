require 'spec_helper'
describe User do

  it "should have a name" do
    u = User.new( :first_name => "Dean", :last_name => "Brundage" )
    u.name.should eq "Dean Brundage"
  end

end
