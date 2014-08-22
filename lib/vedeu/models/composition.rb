module Vedeu
  class Composition
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    def initialize(attributes = {}, &block)
      @attributes = attributes

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    def attributes
      @_attributes ||= defaults.merge!(@attributes)
    end

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
