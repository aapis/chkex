module Chkex
  module Source
    class List < Base
      def initialize(source)
        super(source)
      end

      def process
        @source.each do |url|
          domain = strip(url)

          # strip empty results
          next if domain.strip == ''
          # skip subdomains
          next if domain.scan('.').count > 1

          begin
            record = Whois.whois(domain)
            exp_date = record.parser.expires_on
          rescue Whois::AttributeNotImplemented
            @results[:errors][:no_expiry] = { domain: domain }
            next
          rescue Whois::ConnectionError
            @results[:errors][:connection_error] = { domain: domain }
            next
          rescue Timeout::Error
            @results[:errors][:timeout] = { domain: domain }
            next
          end

          if exp_date.nil?
            @results[:errors][:no_expiry] = { domain: domain }
            next
          end

          expiry_date = Date.parse(exp_date.strftime('%Y-%m-%d'))
          diff = expiry_date.mjd - @now.mjd

          @results[:success][diff] = { expiry: expiry_date, domain: domain }
        end

        @results[:success] = @results[:success].sort_by { |k, _| k }
        @results
      end
    end
  end
end
