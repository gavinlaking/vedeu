# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe Presentation do

      let(:described)  { Vedeu::DSL::Presentation }
      let(:instance)   { Vedeu::Interfaces::DSL.new(model) }
      let(:model)      { Vedeu::Interfaces::Interface.new }
      let(:background) { '#00ff00' }
      let(:foreground) { '#ff00ff' }

      context 'setting both background and foreground' do
        let(:dsl) {
          Vedeu.interface 'my_interface' do
            background '#00ff00'
            foreground '#ff00ff'
          end
        }
        after { Vedeu.interfaces.reset }

        it { dsl.colour.background.colour.must_equal(background) }
        it { dsl.colour.foreground.colour.must_equal(foreground) }
      end

      describe '#background' do
        let(:dsl) {
          Vedeu.interface 'my_interface' do
            background '#00ff00'
          end
        }
        after { Vedeu.interfaces.reset }

        subject { instance.background(background) }

        it do
          dsl.colour.background.must_be_instance_of(Vedeu::Colours::Background)
        end
        it { dsl.colour.background.colour.must_equal(background) }
      end

      describe '#bg' do
        it { instance.must_respond_to(:bg) }
      end

      describe '#bgcolor' do
        it { instance.must_respond_to(:bgcolor) }
      end

      describe '#bg=' do
        it { instance.must_respond_to(:bg=) }
      end

      describe '#bgcolor=' do
        it { instance.must_respond_to(:bgcolor=) }
      end

      describe '#background=' do
        it { instance.must_respond_to(:background=) }
      end

      describe '#foreground' do
        let(:dsl) {
          Vedeu.interface 'my_interface' do
            foreground '#ff00ff'
          end
        }
        after { Vedeu.interfaces.reset }

        subject { instance.foreground(foreground) }

        it do
          dsl.colour.foreground.must_be_instance_of(Vedeu::Colours::Foreground)
        end
        it { dsl.colour.foreground.colour.must_equal(foreground) }
      end

      describe '#fg' do
        it { instance.must_respond_to(:fg) }
      end

      describe '#fgcolor' do
        it { instance.must_respond_to(:fgcolor) }
      end

      describe '#fg=' do
        it { instance.must_respond_to(:fg=) }
      end

      describe '#fgcolor=' do
        it { instance.must_respond_to(:fgcolor=) }
      end

      describe '#foreground=' do
        it { instance.must_respond_to(:foreground=) }
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { instance.colour(attributes) }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it { subject.background.colour.must_equal(background) }
          it { subject.foreground.colour.must_equal('') }
        end
      end

      describe '#colour=' do
        it { instance.must_respond_to(:colour=) }
      end

      describe '#no_wordwrap!' do
        it { instance.must_respond_to(:no_wordwrap!) }

        # @todo Add more tests.
      end

      describe '#style' do
        let(:args) { :bold }

        subject { instance.style(args) }

        it { subject.must_be_instance_of(Vedeu::Presentation::Style) }
      end

      describe '#style=' do
        it { instance.must_respond_to(:style=) }
      end

      describe '#styles' do
        it { instance.must_respond_to(:styles) }
      end

      describe '#styles=' do
        it { instance.must_respond_to(:styles=) }
      end

      describe '#wordwrap' do
        context 'when the value is not given' do
          subject { instance.wordwrap }

          it { subject.must_equal() }
        end

        context 'when the value is given' do
          let(:_value) { false }

          subject { instance.wordwrap(_value) }

          context 'when the value is nil' do
            let(:_value) { nil }

            it { subject.must_equal() }
          end

          context 'when the value is false' do
            it { subject.must_equal() }
          end

          context 'when the value evaluates as true' do
            let(:_value) { :a_true_value }

            it { subject.must_equal() }
          end
        end

        it { instance.must_respond_to(:wordwrap) }
      end

      describe '#wordwrap!' do
        it { instance.must_respond_to(:wordwrap!) }

        # @todo Add more tests.
      end

    end # Presentation

  end # DSL

end # Vedeu
