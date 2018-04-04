require "sinatra"
require "sinatra/json"
require "sinatra/param"
require "mixlib/install"

helpers Sinatra::Param

get "/" do
  erb :home
end

get "/api/v1/metadata/chef" do
  content_type :json

  param :channel, String, default: "stable"
  param :architecture, String, default: "x86_64"
  param :platform, String, required: true
  param :platform_version, String, required: true

  opts = {
    product_name: "chef",
    channel: params[:channel].to_sym,
    architecture: params[:architecture],
    platform: params[:platform],
    platform_version: params[:platform_version],
  }

  mixlib = Mixlib::Install.new(opts)
  metadata = mixlib.artifact_info

  json metadata.to_hash
end
