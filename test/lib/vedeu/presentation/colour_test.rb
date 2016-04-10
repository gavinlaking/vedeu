# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ParentPresentationColourTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    attr_reader :colour

    def initialize
      @colour = { background: '#330000', foreground: '#00aadd' }
      @parent = nil
    end

  end # ParentPresentationColourTestClass

  class PresentationColourTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    attr_reader :parent

    def initialize(attributes = {})
      @colour = attributes[:colour]
      @parent = attributes[:parent]
    end

  end # PresentationColourTestClass

  module Presentation

    describe Colour do

      let(:described)          { Vedeu::Presentation::Colour }
      let(:included_described) { Vedeu::PresentationColourTestClass }
      let(:included_instance)  { included_described.new(attributes) }
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
        subject { included_instance.background }

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
        subject { included_instance.background = '#987654' }

        it do
          included_instance.colour.background.colour.must_equal('#000033')
          subject
          included_instance.colour.background.colour.must_equal('#987654')
        end

        it { subject.must_equal('#987654') }
      end

      describe '#colour' do
        subject { included_instance.colour }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }

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
          Vedeu::Colours::Colour.new(foreground: '#00ff00', background: '#000000')
        }

        subject { included_instance.colour=(colour) }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }
      end

      describe '#foreground' do
        subject { included_instance.foreground }

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
        subject { included_instance.foreground = '#123456' }

        it do
          included_instance.colour.foreground.colour.must_equal('#aadd00')
          subject
          included_instance.colour.foreground.colour.must_equal('#123456')
        end

        it { subject.must_equal('#123456') }
      end

    end # Colour

  end # Presentation

end # Vedeu
