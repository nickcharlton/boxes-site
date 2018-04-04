require File.expand_path "../spec_helper.rb", __FILE__

describe "App" do
  it "has a homepage" do
    get "/"

    expect(last_response).to be_ok
    expect(last_response.body).to include "GitHub"
    expect(last_response.body).to include "Current Boxes"
  end
end

describe "API" do
  let(:json_response) { JSON.parse(last_response.body) }

  it "returns a download url for a given platform and platform version" do
    VCR.use_cassette("mixlib_install_debian_8") do
      get "/api/v1/metadata/chef?platform=debian&platform_version=8"

      expect(last_response).to be_ok
      expect(json_response).to include("platform" => "debian")
      expect(json_response).to include("platform_version" => "8")
      expect(json_response).to include(
        "url" => "https://packages.chef.io/files/stable/chef/14.0.190/" \
                "debian/8/chef_14.0.190-1_amd64.deb",
      )
    end
  end

  it "returns a 400 Bad Request when a required parameter is missing" do
    get "/api/v1/metadata/chef?platform=debian"

    expect(last_response).to be_bad_request
    expect(json_response).to include("message" => "Parameter is required")
  end
end
