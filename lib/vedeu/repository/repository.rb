module Vedeu
  module Repository
    def adaptor
      @adaptor ||= Storage.new
    end

    def adaptor=(adaptor)
      @adaptor = adaptor
    end

    def find(id)
      adaptor.find(self.klass, id)
    end

    def all
      adaptor.all(self.klass)
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
      adaptor.reset(self.klass)
    end
  end
end
