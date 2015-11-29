require 'test_helper'

module Vedeu

  module Presentation

    module Colour

      describe Background do

        let(:includer) { Vedeu::PresentationColourTestClass.new(attributes) }
        let(:attributes) {
          {
            colour: colour,
            parent: parent
          }
        }
        let(:colour)     {
          {
            background: background,
            foreground: foreground
          }
        }
        let(:background) { '#000033' }
        let(:foreground) { '#aadd00' }
        let(:parent)     { Vedeu::ParentPresentationColourTestClass.new }

        describe '#background' do
          subject { includer.background }

          it { subject.must_be_instance_of(Vedeu::Colours::Background) }

          context 'when a colour is not set' do
            let(:colour) {}

            context 'when a parent is not available' do
              let(:parent) {}

              it { subject.colour.must_equal('') }
            end

            context 'when a parent is available' do
              it { subject.colour.must_equal('#330000') }
            end
          end

          context 'when a colour is set' do
            it { subject.colour.must_equal('#000033') }
          end

          # @todo Add more tests.
        end

        describe '#background=' do
          subject { includer.background = '#987654' }

          it {
            includer.colour.background.colour.must_equal('#000033')
            subject
            includer.colour.background.colour.must_equal('#987654')
          }

          it { subject.must_equal('#987654') }
        end

      end # Background

    end # Colour

  end # Presentation

end # Vedeu
