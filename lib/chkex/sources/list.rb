module Chkex
  module Source
    class List < Base
      def initialize(source)
        super(source)
      end

      def process
        @source.each do |url|
          result = DomainInfo.new(url)

          @results[:errors][result.error] = { domain: result.url } unless result.error.nil?

          next unless result.error.nil?

          expiry_date = Date.parse(result.expires_on.strftime('%Y-%m-%d'))
          diff = expiry_date.mjd - @now.mjd

          @results[:success][diff] = { expiry: expiry_date, domain: result.url }
        end

        @results[:success] = @results[:success].sort_by { |k, _| k }
        @results
      end
    end
  end
end
