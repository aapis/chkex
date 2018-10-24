module Chkex
  class DomainInfo
    attr_accessor :error, :url, :expires_on

    def initialize(url)
      @url = url
      @error = nil
      @expires_on = nil

      query
    end

    def query
      begin
        record = Whois.whois(@url)
        @expires_on = record.parser.expires_on

        raise Chkex::DomainNotFound unless @expires_on
      rescue Whois::ServerNotFound
        @error = :no_whois_server
      rescue Whois::AttributeNotImplemented
        @error = :no_expiry
      rescue Whois::ConnectionError
        @error = :connection_error
      rescue Timeout::Error
        @error = :timeout
      rescue Chkex::DomainNotFound => e
        @error = e.message
      rescue NoMethodError
        @error = :no_method
      end
    end
  end
end
