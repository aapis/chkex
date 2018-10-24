module Chkex
  class Checker
    def initialize(domains, type)
      @results = { success: {}, errors: {} }
      @domains = FileHandler.read_list(domains)
      @type = type
    end

    def test
      @results = Source::One.new(@domains).results if @type == :one
      @results = Source::List.new(@domains).results if @type == :multiple

      header('Failed - manually check these', :error)
      print_errors
      header('Passed', :success)
      print_success
    end

    def print_success
      @results[:success].each do |k, v|
        if k <= 50
          if k > 0
            Notify.warning "!! #{v[:domain]} - #{v[:expiry]} (#{k} days away)"
          else
            Notify.warning "!!! #{v[:domain]} - #{v[:expiry]} (EXPIRED #{k*-1} days ago!)"
          end
        else
          Notify.info "#{v[:domain]} - #{v[:expiry]} (#{k} days away)"
        end
      end
    end

    def print_errors
      @results[:errors].each do |k, v|
        Notify.warning "#{v[:domain]} - Reason: #{k}"
      end
    end

    def header(text, type)
      if type == :success
        return unless @results[:success].size > 0
      else
        return unless @results[:errors].size > 0
      end

      Notify.note(text)
    end
  end
end
