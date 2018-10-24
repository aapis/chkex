module Chkex
  module Source
    class One < Base
      def initialize(source)
        super(source)
      end

      def process
        result = DomainInfo.new(@source)
        @results[:errors][result.error] = { domain: result.url } unless result.error.nil?

        return unless result.error.nil?

        expiry_date = Date.parse(result.expires_on.strftime('%Y-%m-%d'))
        diff = expiry_date.mjd - @now.mjd

        @results[:success][diff] = { expiry: expiry_date, domain: result.url }
      end
    end
  end
end
