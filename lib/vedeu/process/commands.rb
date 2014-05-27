module Vedeu
  module Commands
    extend self

    def define(&block)
      if block_given?
        yield self
      else
        self
      end
    end

    def execute(command = "")
      commands.fetch(command).call if exists?(command)
    end

    def list
      commands.inspect
    end

    def add(name, klass, args = [], options = {})
      commands.merge!(Command.define(name, klass, args, options))
    end

    private

    def exists?(command)
      commands.fetch(command, false)
    end

    def commands
      @commands ||= { :exit => Proc.new { Exit.dispatch } }
    end
  end
end
