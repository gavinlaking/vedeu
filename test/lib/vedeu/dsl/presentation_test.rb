require 'test_helper'

module Vedeu

  module DSL

    describe Presentation do

      let(:described)  { Vedeu::DSL::Presentation }
      let(:instance)   { Vedeu::DSL::Interface.new(model) }
      let(:model)      { Vedeu::Interface.new }
      let(:background) { '#00ff00' }
      let(:foreground) { '#ff00ff' }

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
        it { dsl.colour.background.must_be_instance_of(Vedeu::Background) }
        it { dsl.colour.background.colour.must_equal(background) }

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
        it { dsl.colour.foreground.must_be_instance_of(Vedeu::Foreground) }
        it { dsl.colour.foreground.colour.must_equal(foreground) }

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
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { instance.colour(attributes) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              background: '#00ff00', foreground: ''
            )
          end
        end
      end

      describe '#style' do
        let(:args) { :bold }

        subject { instance.style(args) }

        it { instance.must_respond_to(:styles) }

        it { subject.must_be_instance_of(Vedeu::Style) }
      end

    end # Presentation

  end # DSL

end # Vedeu
