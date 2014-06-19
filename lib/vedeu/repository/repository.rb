module Vedeu
  module Repository
    def adaptor
      @adaptor ||= Storage.new
    end

    def find(name)
      adaptor.find(klass, name)
    end

    def all
      adaptor.all(klass)
    end

    def query(klass, attribute, value)
      adaptor.query(klass, attribute, value)
    end

    def create(model)
      adaptor.create(model)
    end

    def delete(model)
      adaptor.delete(model)
    end

    def reset
      adaptor.reset(klass)
    end
  end
end
