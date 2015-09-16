require 'test_helper'

module Vedeu

  module DSL

    describe Presentation do

      let(:described)  { Vedeu::DSL::Presentation }
      let(:instance)   { Vedeu::DSL::Interface.new(model) }
      let(:model)      { Vedeu::Models::Interface.new }
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

        it { instance.must_respond_to(:bg) }
        it { instance.must_respond_to(:bgcolor) }
        it { instance.must_respond_to(:bg=) }
        it { instance.must_respond_to(:bgcolor=) }
        it { instance.must_respond_to(:background=) }
        it {
          dsl.colour.background.must_be_instance_of(Vedeu::Colours::Background)
        }
        it { dsl.colour.background.colour.must_equal(background) }
      end

      describe '#foreground' do
        let(:dsl) {
          Vedeu.interface 'my_interface' do
            foreground '#ff00ff'
          end
        }
        after { Vedeu.interfaces.reset }

        subject { instance.foreground(foreground) }

        it { instance.must_respond_to(:fg) }
        it { instance.must_respond_to(:fgcolor) }
        it { instance.must_respond_to(:fg=) }
        it { instance.must_respond_to(:fgcolor=) }
        it { instance.must_respond_to(:foreground=) }
        it {
          dsl.colour.foreground.must_be_instance_of(Vedeu::Colours::Foreground)
        }
        it { dsl.colour.foreground.colour.must_equal(foreground) }
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { instance.colour(attributes) }

        it { instance.must_respond_to(:colour=) }
        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it { subject.background.colour.must_equal(background) }
          it { subject.foreground.colour.must_equal('') }
        end
      end

      describe '#style' do
        let(:args) { :bold }

        subject { instance.style(args) }

        it { instance.must_respond_to(:style=) }
        it { instance.must_respond_to(:styles) }
        it { instance.must_respond_to(:styles=) }

        it { subject.must_be_instance_of(Vedeu::Presentation::Style) }
      end

    end # Presentation

  end # DSL

end # Vedeu
