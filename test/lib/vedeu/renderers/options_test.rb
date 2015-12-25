# frozen_string_literal: true

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

      describe '#options=' do
        it { instance.must_respond_to(:options=) }
      end

      describe '#compress?' do
        subject { instance.compress? }

        context 'when the option is not set or is set to false' do
          before { options.tap { |o| o.delete(:compression) } }

          context 'when Vedeu::Configuration.compression? is set to false' do
            before { Vedeu::Configuration.stubs(:compression?).returns(false) }

            it { subject.must_equal(false) }
          end

          context 'when Vedeu::Configuration.compression? is set to true' do
            before { Vedeu::Configuration.stubs(:compression?).returns(true) }

            it { subject.must_equal(true) }
          end
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
