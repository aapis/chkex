require 'date'
require 'notifaction'
require 'whois-parser'

require 'chkex/version'
require 'chkex/file-handler'
require 'chkex/checker'
require 'chkex/sources/base'
require 'chkex/sources/list'
require 'chkex/sources/one'

module Chkex
  class DomainNotFound < StandardError
    def initialize(msg='domain_not_registered')
      super(msg)
    end
  end

  def self.run(source)
    Checker.new(source, :multiple).test
  end

  def self.run_one(source)
    Checker.new(source, :one).test
  end
end
