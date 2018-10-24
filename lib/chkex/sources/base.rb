module Chkex
  module Source
    class Base
      attr_accessor :results

      def initialize(source_list)
        @now = Date.today
        @source = source_list
        @results = { success: {}, errors: {} }

        process
      end

      def strip(url)
        url.gsub('http://', '')
          .gsub('https://', '')
          .gsub('www.', '')
          .gsub('/', '')
      end

      # def process_list
      #   result = Process.new(url)

      #   @results[:errors][result.error] = { domain: result.url } unless result.error.nil?

      #   next unless result.error.nil?

      #   expiry_date = Date.parse(result.expires_on.strftime('%Y-%m-%d'))
      #   diff = expiry_date.mjd - @now.mjd

      #   @results[:success][diff] = { expiry: expiry_date, domain: result.url }
      # end
    end
  end
end
