require 'test_helper'

module Vedeu

  module Renderers

    class RenderersTestClass
      include Vedeu::Renderers::Options

      def initialize(options = {})
        @options = options || {}
      end
    end

    describe Options do

      let(:described) { Vedeu::Renderers::Options }
      let(:instance)  { RenderersTestClass.new(options) }
      let(:options)   {
        {
          compression: compression,
        }
      }
      let(:compression) { false }

      describe 'accessors' do
        it { instance.must_respond_to(:options=) }
      end

      describe '#compress?' do
        subject { instance.compress? }

        context 'when the option is not set' do
          before { options.tap { |o| o.delete(:compression) } }

          it { subject.must_equal(false) }
        end

        context 'when the option is set and is false' do
          let(:compression) { false }

          it { subject.must_equal(false) }
        end

        context 'when the option is set and is true' do
          let(:compression) { true }

          it { subject.must_equal(true) }
        end
      end

      # @todo Add more tests.
      # it { skip }

    end # Options

  end # Renderers

end # Vedeu
