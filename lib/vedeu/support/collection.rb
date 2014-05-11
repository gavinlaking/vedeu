module Vedeu
  class Collection
    include Singleton
    attr_writer :collection

    def self.instance
      @instance ||= new
    end

    def self.reset
      @instance = new
    end

    def update(key = nil, value = nil)
      return false unless key && value
      collection[key_as_sym(key)] = value
      true
    end

    def debug
      collection
    end
    alias_method :show, :debug

    def clear
      Collection.reset
    end

    private

    def collection
      @collection ||= {}
    end

    def key_as_sym(key)
      if key.is_a?(String)
        key.downcase.to_sym
      elsif key.is_a?(Symbol)
        key
      end
    end
  end
end
