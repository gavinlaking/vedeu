module Vedeu

  class GlobalKeymap

    def initialize
    end

    def define(key, action)
      if valid?(key)
      end
    end

    def defined?(key)
      storage.include?(key)
    end

    private

    def valid?(key)
      if defined?(key)
        fail KeyInUse, "'#{key}' is already in use as a global key."
      end

      true
    end

  end # GlobalKeymap

  class SystemKeymap

    def initialize
    end

    def define(key, action)
      if valid?(key)
      end
    end

    def defined?(key)
      storage.include?(key)
    end

    private

    def valid?(key)
      if defined?(key)
        fail KeyInUse, "'#{key}' is already in use by the system."
      end

      true
    end

  end # SystemKeymap

  class UserKeymap

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def define(key, action)
      if valid?(key)
      end
    end

    def defined?(key)
      storage.include?(key)
    end

    private

    def storage
      {

      }
    end

    def valid?(key)
      if defined?(key)
        fail KeyInUse, "'#{key}' is already in use by this interface."
      end

      true
    end

  end # UserKeymap

end # Vedeu
