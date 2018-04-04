require "rack/test"
require "rspec"

require File.expand_path "./support/vcr_setup.rb", __dir__

require File.expand_path "../../app.rb", __FILE__

ENV["RACK_ENV"] = "test"

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure { |c| c.include RSpecMixin }
