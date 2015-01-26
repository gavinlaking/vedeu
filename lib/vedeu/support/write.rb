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

    # @return [Array<Array>|Array<String>|String]
    def write
      processed
    end

    private

    attr_reader :console, :data

    # @return [Array<Array>|Array<String>|String]
    def processed
      if data
        if data.is_a?(Array)
          if data.first.is_a?(Array)
            content = data
            streams(lines(content))

          elsif data.first.is_a?(String)
            content = data
            streams(lines(content))

          else
            # unknown type, cannot process
            ''

          end

        elsif data.is_a?(String)
          content = data.split(/\n/)
          streams(lines(content))

        else
          # unknown type, cannot process
          ''

        end
      else
        # no data, cannot process
        ''

      end
    end

    # @return [Array<Array>|Array<String>]
    def lines(content)
      truncate_lines(content)
    end

    # @return [Array<Char>|Array<String>|NilClass]
    def streams(lines)
      lines.map do |line|
        if line.is_a?(Array)
          truncate_columns(line)

        elsif line.is_a?(String)
          # what about line breaks?
          truncate_columns(line.chars)

        else
          nil

        end
      end.compact
    end

    # @return [Array<Char>|Array<String>|String]
    def truncate_columns(line)
      if line.size > visible_columns
        line[0, visible_columns]

      else
        line

      end
    end

    # @return [Array<Array>|Array<String>]
    def truncate_lines(lines)
      if lines.size > visible_lines
        lines[0, visible_lines]

      else
        lines

      end
    end

    # @return [Fixnum]
    def visible_columns
      console.width - 1
    end

    # @return [Fixnum]
    def visible_lines
      console.height - 1
    end

  end # Write

end # Vedeu
