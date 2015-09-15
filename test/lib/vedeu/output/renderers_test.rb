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

          it { subject.must_equal(output) }
        end
      end
    end

    describe '.render' do
      let(:output) {}

      before do
        Vedeu::Renderers.reset
        Vedeu::Renderers.renderer(DummyRenderer)
      end

      subject { described.render(output) }

      # it { subject.must_be_instance_of(Array) }

      it {
        DummyRenderer.expects(:render).with(output)
        subject
      }

      context 'when there is content' do
        let(:output) {
          Vedeu::Models::Escape.new(value: Vedeu::Esc.hide_cursor)
        }

        it { subject.must_be_instance_of(Vedeu::Models::Escape) }
      end

      context 'when there is no content' do
        it { subject.must_be_instance_of(NilClass) }
      end
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
