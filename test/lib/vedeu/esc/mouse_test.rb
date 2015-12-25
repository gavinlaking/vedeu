# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module EscapeSequences

    describe Mouse do

      let(:described) { Vedeu::EscapeSequences::Mouse }

      describe '.disable_mouse' do
        subject { described.disable_mouse }

        context 'when the mouse is enabled in the configuration' do
          it { subject.must_equal("\e[?9l") }
        end

        context 'when the mouse is not enabled in the configuration' do
          before { Vedeu::Configuration.stubs(:mouse?).returns(false) }

          it { subject.must_equal('') }
        end
      end

      describe '.enable_mouse' do
        subject { described.enable_mouse }

        context 'when the mouse is enabled in the configuration' do
          it { subject.must_equal("\e[?9h") }
        end

        context 'when the mouse is not enabled in the configuration' do
          before { Vedeu::Configuration.stubs(:mouse?).returns(false) }

          it { subject.must_equal('') }
        end
      end

      describe '.mouse_x10_on' do
        it { described.mouse_x10_on.must_equal("\e[?9h") }
      end

      describe '.mouse_x10_off' do
        it { described.mouse_x10_off.must_equal("\e[?9l") }
      end

      describe '.mouse_on' do
        it { described.mouse_on.must_equal("\e[?1000h") }
      end

      describe '.mouse_off' do
        it { described.mouse_off.must_equal("\e[?1000l") }
      end

    end # Mouse

  end # EscapeSequences

end # Vedeu
