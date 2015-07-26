require 'test_helper'

module Vedeu

  class DummyRenderer
    def self.render
      :dummy
    end
  end

  class FooRenderer
    def self.render
      :foo
    end
  end

  describe Renderers do

    let(:described) { Vedeu::Renderers }
    let(:output)    {}

    before { Vedeu::Renderers.reset }
    after  { Vedeu::Renderers.reset }

    describe '.renderers' do
      subject { described.renderers }

      it { subject.must_be_instance_of(Module) }

      context 'API' do
        before { Vedeu::Renderers.renderer(*renderers) }

        subject { Vedeu.renderers.render(output) }

        # @todo Add more tests.
        # context 'when a single renderer is defined' do
        #   let(:renderers) { DummyRenderer }

        #   it { subject.must_equal([:dummy]) }
        # end

        # @todo Add more tests.
        # context 'when multiple renderers are defined' do
        #   let(:renderers) { [DummyRenderer, FooRenderer] }

        #   it { subject.must_equal([:dummy, :foo]) }
        # end

        context 'when no renderers are defined' do
          let(:renderers) {}

          it { subject.must_equal([]) }
        end
      end
    end

    describe '.render' do
      let(:args) {}

      subject { described.render(args) }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.renderer' do
      let(:renderers) {}

      subject { described.renderer(*renderers) }

      it { subject.must_be_instance_of(Set) }

      context 'with a single renderer' do
        let(:renderers) { DummyRenderer }

        it { subject.size.must_equal(1) }
      end

      context 'with multiple renderers' do
        let(:renderers) { [DummyRenderer, FooRenderer] }

        it { subject.size.must_equal(2) }
      end

      context 'with no renderer' do
        let(:renderers) {}

        it { subject.size.must_equal(0) }
      end
    end

    describe '.reset' do
      subject { described.reset }

      it { subject.must_be_instance_of(Set) }
      it { subject.size.must_equal(0) }
    end

  end # Renderers

end # Vedeu
