require 'test_helper'

module Vedeu

  class ParentPresentationColourTestClass
    include Vedeu::Presentation

    def parent
      nil
    end

    def attributes
      {
        colour: { background: '#330000', foreground: '#00aadd' },
      }
    end
  end

  class PresentationColourTestClass

    include Vedeu::Presentation

    attr_reader :attributes
    attr_reader :parent

    def initialize(attributes = {})
      @attributes = attributes
      @parent     = @attributes[:parent]
    end

  end # PresentationTestClass

  module Presentation

    module Colour

      describe Foreground do

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

        describe '#foreground' do
          subject { includer.foreground }

          it { subject.must_be_instance_of(Vedeu::Colours::Foreground) }
          it { subject.colour.must_equal('#aadd00') }

          context 'when a colour is not set' do
            let(:colour) {}

            context 'when a parent is not available' do
              let(:parent) {}

              it { subject.colour.must_equal('') }
            end

            context 'when a parent is available' do
              it { subject.colour.must_equal('#00aadd') }
            end
          end

          context 'when a colour is set' do
            it { subject.colour.must_equal('#aadd00') }
          end

          # @todo Add more tests.
        end

        describe '#foreground=' do
          subject { includer.foreground = '#123456' }

          it {
            includer.colour.foreground.colour.must_equal('#aadd00')
            subject
            includer.colour.foreground.colour.must_equal('#123456')
          }

          it { subject.must_equal('#123456') }
        end

      end # Foreground

    end # Colour

  end # Presentation

end # Vedeu
