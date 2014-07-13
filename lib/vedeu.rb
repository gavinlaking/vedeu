require 'date'
require 'logger'

require_relative 'vedeu/repository/command_repository'
require_relative 'vedeu/repository/interface_repository'
require_relative 'vedeu/support/exit'
require_relative 'vedeu/launcher'
require_relative 'vedeu/version'

module Vedeu
  # :nocov:
  module ClassMethods
    def command(name, options = {})
      CommandRepository.create({ name: stringify_symbols(name) }
                       .merge!(options))
    end

    def interface(name, options = {})
      InterfaceRepository.create({ name: stringify_symbols(name) }
                         .merge!(options))
    end

    private

    def stringify_symbols(value)
      value.is_a?(::Symbol) ? value.to_s : value
    end
  end

  def self.logger
    @logger ||= Logger.new(root_path + '/logs/vedeu.log').tap do |log|
      log.formatter = proc do |_, time, _, msg|
        "\n#{time.iso8601}: #{msg}\n"
      end
    end
  end

  def self.debug(filename = 'profile.html', &block)
    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open(Vedeu.root_path + '/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end

  private

  def self.root_path
    File.expand_path('../..', __FILE__)
  end
  # :nocov:
end
