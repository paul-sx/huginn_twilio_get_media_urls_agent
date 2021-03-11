require 'rails_helper'
require 'huginn_agent/spec_helper'

describe Agents::TwilioGetMediaUrlsAgent do
  before(:each) do
    @valid_options = Agents::TwilioGetMediaUrlsAgent.new.default_options
    @checker = Agents::TwilioGetMediaUrlsAgent.new(:name => "TwilioGetMediaUrlsAgent", :options => @valid_options)
    @checker.user = users(:bob)
    @checker.save!
  end

  pending "add specs here"
end
