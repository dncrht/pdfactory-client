require "pdfactory/client/version"
require 'base64'
require 'faraday'

module PDFactory
  class Client
    class ArgumentError < StandardError; end

    def initialize(url: ENV['PDFACTORY_URL'], user: ENV['PDFACTORY_USER'], password: ENV['PDFACTORY_PASSWORD'])
      url or raise ArgumentError.new('Service URL not set')
      if blank?(user) && blank?(password)
        # Allowed for open servers (eg: local)
      else
        user or raise ArgumentError.new('User must be set')
        password or raise ArgumentError.new('Password must be set')
      end

      @url = url
      @user = user
      @password = password
    end

    def html2pdf(html)
      pdf = call_api('/pdf', { html: html })
      return unless pdf

      Base64.decode64(pdf)
    end

    private

    def call_api(endpoint, body, http_method = :post)
      response = connection.send(http_method) do |response|
        response.url(endpoint)
        response.body = URI.encode_www_form(body)
      end

      if response.success?
        response.body
      else
        nil
      end
    end

    def connection
      @connection ||= Faraday.new(@url) do |connection|
        connection.basic_auth @user, @password
        connection.adapter Faraday.default_adapter
      end
    end

    def blank?(value)
      value.nil? || value.empty?
    end
  end
end
