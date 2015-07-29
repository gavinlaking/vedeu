require 'test_helper'

module Vedeu

  class ParentPresentationTestClass
    include Vedeu::Presentation

    def parent
      nil
    end

    def attributes
      {
        colour: { background: '#330000', foreground: '#00aadd' },
        style:  ['bold']
      }
    end
  end

  class PresentationTestClass
    include Vedeu::Presentation

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parent
      Vedeu::ParentPresentationTestClass.new
    end

  end # PresentationTestClass

  module Presentation

    describe Style do

      let(:includer) { Vedeu::PresentationTestClass.new(attributes) }
      let(:attributes) {
        {
          colour: { background: background, foreground: foreground },
          style:  ['bold']
        }
      }
      let(:background) { '#000033' }
      let(:foreground) { '#aadd00' }

      describe '#parent_style' do
        subject { includer.parent_style }

        it { subject.must_be_instance_of(Vedeu::Style) }

        context 'when a parent is available' do
          it { subject.value.must_equal(['bold']) }
        end

        context 'when a parent is not available' do
          before { includer.stubs(:parent).returns(nil) }

          it { subject.value.must_equal(nil) }
        end
      end

      describe '#style' do
        subject { includer.style }

        it { subject.must_be_instance_of(Vedeu::Style) }
      end

      describe '#style=' do
        let(:style) { Vedeu::Style.new('normal') }

        subject { includer.style = (style) }

        it { subject.must_be_instance_of(Vedeu::Style) }
      end

    end # Style

  end # Presentation

end # Vedeu
