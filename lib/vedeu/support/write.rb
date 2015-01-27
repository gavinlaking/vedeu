module Vedeu

  # The basis of a fake output device.
  class Write

    # @see Vedeu::Write#write
    def self.to(console, data = nil)
      new(console, data).write
    end

    # @return [Vedeu::Write]
    def initialize(console, data = nil)
      @console = console
      @data    = data
    end

    def print(string)
      @data = string

      write
    end

    # @return [Array<Array>|Array<String>]
    def write
      streams
    end

    private

    attr_reader :console, :data

    # @return [Array<Char>|Array<String>]
    def streams
      lines.map do |line|
        if line.size > visible_columns
          line[0, visible_columns]

        else
          line

        end
      end
    end

    # @return [Array<Array>|Array<String>]
    def lines
      if content.size > visible_lines
        content[0, visible_lines]

      else
        content

      end
    end

    def content
      if data.nil? || data.empty?
        []

      elsif data.is_a?(String)
        data.split(/\n/)

      else
        data

      end
    end

    # @return [Fixnum]
    def visible_columns
      console.width #- 1
    end

    # @return [Fixnum]
    def visible_lines
      console.height #- 1
    end

  end # Write

end # Vedeu
