# frozen_string_literal: true

require 'json'
require "net/http"
require "uri"
require "cgi"

module ScreenshotOneApi
  class Client

    BASE_URL = "https://api.screenshotone.com"

    def initialize(access_key, secret_key = nil)
      @access_key = access_key
      @secret_key = secret_key
    end

    def generate_take_url(options)
      raise Error.new('Argument is not a ScreenshotOneApi::TakeOptions instance') unless options.is_a?(TakeOptions)
      raise Error.new('TakeOptions is not valid') unless options.valid?

      query = options.to_hash
      query[:access_key] = @access_key
      query_string = URI.encode_www_form(query)
      if @secret_key
        puts "Secret key: #{@secret_key}"
        query_string << "&signature=#{OpenSSL::HMAC.hexdigest("sha256", @secret_key, query_string)}"
      end

      "#{BASE_URL}/take?#{query_string}"
    end

    def take(options)
      uri = URI.parse(generate_take_url(options))
      res = Net::HTTP.get_response(uri)
      return res.body if res.is_a?(Net::HTTPSuccess)
      raise Error.new(res.body)
    end

  end
end