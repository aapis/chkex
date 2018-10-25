module Chkex
  module Source
    class One < Base
      def initialize(source)
        super(source)
      end

      def process
        result = DomainInfo.new(@source)

        unless result.error.nil?
          @results[:errors][result.error] = [] unless @results[:errors].key?(result.error)
          @results[:errors][result.error].push(domain: result.url)
        end

        return if result.expires_on.nil?

        expiry_date = Date.parse(result.expires_on.strftime('%Y-%m-%d'))
        diff = expiry_date.mjd - @now.mjd

        @results[:success][diff] = [] unless @results[:success].key?(diff)
        @results[:success][diff].push(expiry: expiry_date, domain: result.url)
      end
    end
  end
end
