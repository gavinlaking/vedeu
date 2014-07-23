require 'date'
require 'logger'

require_relative 'vedeu/models/builders/command_builder'
require_relative 'vedeu/models/builders/interface_builder'
require_relative 'vedeu/support/events'
require_relative 'vedeu/support/geometry'
require_relative 'vedeu/support/menu'
require_relative 'vedeu/support/exit'
require_relative 'vedeu/launcher'

module Vedeu
  # :nocov:
  module ClassMethods
    def command(name, &block)
      CommandBuilder.build(name, &block)
    end

    def interface(name, &block)
      InterfaceBuilder.build(name, &block)
    end

    def event(name, &block)
      Vedeu.events.on(name, &block)
    end
    alias_method :on, :event

    def run(name, *args)
      Vedeu.events.trigger(name, *args)
    end
    alias_method :trigger, :run
  end

  def self.events
    @events ||= Events.new do
      on(:_exit_)        { fail StopIteration }
      on(:_log_)         { |message| Vedeu.logger.debug(message) }
      on(:_mode_switch_) { fail ModeSwitch    }

      on(:_keypress_) do |key|
        trigger(:key, key)
        trigger(:_log_, "key: #{key}")
        trigger(:_mode_switch_) if key == :escape
      end
    end
  end

  def self.logger
    @logger ||= Logger.new(root_path + '/logs/vedeu.log').tap do |log|
      log.formatter = proc do |_, time, _, msg|
        "\n#{time.iso8601}: #{msg}\n"
      end
    end
  end

  def self.error(exception)
    logger.debug "\e[38;5;196mError:\e[38;2;39m\e[48;2;49m " +
                 "#{exception.message}\n\n" +
                 exception.backtrace.join("\n")
  end

  def self.debug(filename = 'profile.html', &block)
    require 'ruby-prof'

    RubyProf.start

    yield

    result = RubyProf.stop
    result.eliminate_methods!([/^Array/, /^Hash/])

    File.open(Vedeu.root_path + '/tmp/' + filename, 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
      # RubyProf::GraphPrinter.new(result).print(file)
    end
  end

  def self.included(receiver)
    receiver.send :include, ClassMethods
    receiver.extend(ClassMethods)
  end

  extend ClassMethods

  private

  def self.root_path
    File.expand_path('../..', __FILE__)
  end
  # :nocov:
end
