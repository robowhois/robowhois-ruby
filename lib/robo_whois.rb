#--
# RoboWhois
#
# Ruby client for the RoboWhois API.
#
# Copyright (c) 2012 RoboDomain Inc.
#++


require 'robo_whois/version'
require 'httparty'


class RoboWhois
  include HTTParty

  base_uri "http://api.robowhois.com"

  attr_reader :last_response


  def initialize(api_key)
    @auth = { :username => api_key, :password => "X" }
  end

  def api_key
    @auth[:username]
  end


  def account
    get("/account")["account"]
  end

  def whois(query)
    get("/whois/#{query}")
  end

  def whois_availability(query)
    get("/whois/#{query}/availability")["response"]
  end

  def whois_parts(query)
    get("/whois/#{query}/parts")["response"]
  end

  def whois_properties(query)
    get("/whois/#{query}/properties")["response"]
  end

  def whois_record(query)
    get("/whois/#{query}/record")["response"]
  end


private

  def get(path, params = {})
    request(:get, path, options(:query => params))
  end

  def request(method, path, options)
    @last_response = self.class.send(method, path, options)
  end

  def options(hash = {})
    hash[:headers] ||= {}
    hash[:headers]["User-Agent"] = "RoboWhois Ruby #{VERSION}"
    hash[:basic_auth] = @auth
    hash
  end

end
