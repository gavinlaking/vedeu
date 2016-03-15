# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ParentPresentationStyleTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    attr_reader :style

    def initialize
      @style  = ['underline']
      @parent = nil
    end

  end # ParentPresentationStyleTestClass

  class PresentationStyleTestClass

    include Vedeu::Presentation
    include Vedeu::Presentation::Colour
    include Vedeu::Presentation::Position
    include Vedeu::Presentation::Styles

    attr_reader :parent

    def initialize(attributes = {})
      @style  = attributes[:style]
      @parent = attributes[:parent]
    end

  end # PresentationTestClass

  module Presentation

    describe Styles do

      let(:described)          { Vedeu::Presentation::Styles }
      let(:included_described) { Vedeu::PresentationStyleTestClass }
      let(:included_instance)  { included_described.new(attributes) }
      let(:attributes) {
        {
          parent: parent,
          style:  style,
        }
      }
      let(:parent) { Vedeu::ParentPresentationStyleTestClass.new }
      let(:style)  { ['bold'] }

      describe '#style' do
        subject { included_instance.style }

        it { subject.must_be_instance_of(Vedeu::Presentation::Style) }

        context 'when the attribute is not set' do
          let(:style) {}

          context 'when a parent is available' do
            it { subject.value.must_equal(['underline']) }
          end

          context 'when a parent is not available' do
            let(:parent) {}

            it { subject.value.must_equal(nil) }
          end
        end

        context 'when the attribute is set' do
          it { subject.value.must_equal(['bold']) }
        end
      end

      describe '#style=' do
        let(:style) { Vedeu::Presentation::Style.new('normal') }

        subject { included_instance.style = (style) }

        it { subject.must_be_instance_of(Vedeu::Presentation::Style) }
      end

    end # Style

  end # Presentation

end # Vedeu
