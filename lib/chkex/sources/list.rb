module Chkex
  module Source
    class List < Base
      def initialize(source)
        super(source).organize
      end

      def process
        Notify.info "Checking #{@source.size} domains..."

        @source.each do |url|
          result = DomainInfo.new(url)

          unless result.error.nil?
            @results[:errors][result.error] = [] unless @results[:errors].key?(result.error)
            @results[:errors][result.error].push(domain: result.url)
          end

          next if result.expires_on.nil?

          expiry_date = Date.parse(result.expires_on.strftime('%Y-%m-%d'))
          diff = expiry_date.mjd - @now.mjd

          @results[:success][diff] = [] unless @results[:success].key?(diff)
          @results[:success][diff].push(expiry: expiry_date, domain: result.url)
        end

        self
      end

      def organize
        @results[:success] = @results[:success].sort_by { |k, _| k }
        @results
      end
    end
  end
end
