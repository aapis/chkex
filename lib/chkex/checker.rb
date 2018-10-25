module Chkex
  class Checker
    def initialize(domains, type)
      @results = { success: {}, errors: {} }
      @domains = FileHandler.read_list(domains)
      @type = type
    end

    def test
      case @type
      when :one
        @results = Source::One.new(@domains).results
      when :multiple
        @results = Source::List.new(@domains).results
      else
        raise Chkex::InitializationError
      end

      print_output
    end

    private

    def print_output
      header('Failed - manually check these', :error)
      print_errors
      header('Passed', :success)
      print_success

      @results
    end

    def print_success
      @results[:success].each do |k, v|
        v.each do |h|
          if k <= 50
            if k > 0
              Notify.warning "!! #{h[:domain]} - #{h[:expiry]} (#{k} days away)"
            else
              Notify.warning "!!! #{h[:domain]} - #{h[:expiry]} (EXPIRED #{k*-1} days ago!)"
            end
          else
            Notify.info "#{h[:domain]} - #{h[:expiry]} (#{k} days away)"
          end
        end
      end
    end

    def print_errors
      @results[:errors].each do |k, v|
        v.each do |h|
          Notify.warning "#{h[:domain]} - Reason: #{k}"
        end
      end
    end

    def header(text, type)
      if type == :success
        return if @results[:success].empty?
      else
        return if @results[:errors].empty?
      end

      Notify.note(text)
    end
  end
end
