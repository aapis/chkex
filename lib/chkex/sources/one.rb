module Chkex
  module Source
    class One < Base
      def initialize(source)
        super(source)
      end

      def process
        begin
          record = Whois.whois(@source)
          exp_date = record.parser.expires_on

          raise Chkex::DomainNotFound unless exp_date
        rescue Whois::AttributeNotImplemented
          @results[:errors][:no_expiry] = { domain: @source }
        rescue Whois::ConnectionError
          @results[:errors][:connection_error] = { domain: @source }
        rescue Timeout::Error
          @results[:errors][:timeout] = { domain: @source }
        rescue Chkex::DomainNotFound => e
          @results[:errors][e.message] = { domain: @source }
        end

        return @results unless @results[:errors].empty?

        expiry_date = Date.parse(exp_date.strftime('%Y-%m-%d'))
        diff = expiry_date.mjd - @now.mjd

        @results[:success][diff] = { expiry: expiry_date, domain: @source }
        @results[:success].sort_by { |k, _| k }
        @results
      end
    end
  end
end