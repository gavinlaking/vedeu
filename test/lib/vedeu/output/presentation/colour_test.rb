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

    describe Colour do

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

        it { subject.must_be_instance_of(Vedeu::Background) }

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

      describe '#foreground' do
        subject { includer.foreground }

        it { subject.must_be_instance_of(Vedeu::Foreground) }
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

      describe '#colour' do
        subject { includer.colour }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        context 'when a colour is not set' do
          let(:colour) {}

          context 'when a parent is not available' do
            let(:parent) {}

            it { subject.background.colour.must_equal('') }
            it { subject.foreground.colour.must_equal('') }
          end

          context 'when a parent is available' do
            it { subject.background.colour.must_equal('#330000') }
            it { subject.foreground.colour.must_equal('#00aadd') }
          end
        end

        context 'when a colour is set' do
          it { subject.background.colour.must_equal('#000033') }
          it { subject.foreground.colour.must_equal('#aadd00') }
        end
      end

      describe '#colour=' do
        let(:colour) {
          Vedeu::Colour.new(foreground: '#00ff00', background: '#000000')
        }

        subject { includer.colour=(colour) }

        it { subject.must_be_instance_of(Vedeu::Colour) }
      end

    end # Colour

  end # Presentation

end # Vedeu
