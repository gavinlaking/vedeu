# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class DummyRenderer
    def self.render(*output)
      :dummy
    end
  end

  class FooRenderer
    def self.render(*output)
      :foo
    end
  end

  describe Renderers do

    let(:described) { Vedeu::Renderers }
    let(:output)    {}

    before {
      Vedeu.stubs(:log)
      Vedeu::Renderers.reset
    }
    after  { Vedeu::Renderers.reset }

    describe '.renderers' do
      subject { described.renderers }

      it { subject.must_be_instance_of(Module) }
    end

    describe '.render' do
      it { described.must_respond_to(:render) }
    end

  end # Renderers

end # Vedeu
