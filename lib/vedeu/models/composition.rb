module Vedeu
  class Composition

    attr_reader :attributes

    # @param  []
    # @param []
    # @return []
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param  []
    # @param []
    # @return []
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return []
    def interfaces
      @interfaces ||= if attributes[:interfaces].nil? || attributes[:interfaces].empty?
        []

      else
        [ attributes[:interfaces] ].flatten.map do |attrs|
          stored = Store.query(attrs[:name])

          combined = stored.merge(attrs) do |key, s, a|
            key == :lines && s.empty? ? a : s
          end

          Interface.new(combined)
        end

      end
    end

    # @return []
    def to_s
      interfaces.map(&:to_s).join
    end

    private

    def defaults
      {
        interfaces: []
      }
    end

  end
end
