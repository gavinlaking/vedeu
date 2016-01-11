# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe Mouse do

      let(:described) { Vedeu::Input::Mouse }
      let(:instance)  { described.new(input) }
      let(:input)     {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
      end

      describe '.click' do
        before { Vedeu.interface(:mouse_test) {} }
        after  { Vedeu.interfaces.reset! }

        subject { described.click(input) }

        context 'when the left mouse button was pressed' do
          let(:input) { "\e[M ,%" }

          it do
            Vedeu.expects(:trigger).with(:_mouse_event_, input)
            Vedeu.expects(:trigger).
              with(:_cursor_reposition_, Vedeu.focus, 5, 12)
            subject
          end
        end

        context 'when the mouse scroll wheel was moved upwards' do
          let(:input) { "\e[M`6E" }

          it do
            Vedeu.expects(:trigger).with(:_mouse_event_, input)
            Vedeu.expects(:trigger).with(:_cursor_up_, Vedeu.focus)
            subject
          end
        end

        context 'when the mouse scroll wheel was moved downwards' do
          let(:input) { "\e[MaN5" }

          it do
            Vedeu.expects(:trigger).with(:_mouse_event_, input)
            Vedeu.expects(:trigger).with(:_cursor_down_, Vedeu.focus)
            subject
          end
        end

        context 'when the mouse input was not recognised' do
          let(:input) { "\e[Mb0(" }

          it { subject.must_equal(false) }
        end
      end

      describe '#click' do
        it { instance.must_respond_to(:click) }
      end

    end # Mouse

  end # Input

end # Vedeu
