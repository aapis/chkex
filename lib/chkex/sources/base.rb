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
    end
  end
end