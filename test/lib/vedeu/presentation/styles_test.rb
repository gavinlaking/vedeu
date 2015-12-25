# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ParentPresentationStyleTestClass

    include Vedeu::Presentation

    attr_reader :style

    def initialize
      @style  = ['underline']
      @parent = nil
    end

  end # ParentPresentationStyleTestClass

  class PresentationStyleTestClass

    include Vedeu::Presentation

    attr_reader :parent

    def initialize(attributes = {})
      @style  = attributes[:style]
      @parent = attributes[:parent]
    end

  end # PresentationTestClass

  module Presentation

    describe Styles do

      let(:includer) { Vedeu::PresentationStyleTestClass.new(attributes) }
      let(:attributes) {
        {
          parent: parent,
          style:  style,
        }
      }
      let(:parent) { Vedeu::ParentPresentationStyleTestClass.new }
      let(:style)  { ['bold'] }

      describe '#style' do
        subject { includer.style }

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

        subject { includer.style = (style) }

        it { subject.must_be_instance_of(Vedeu::Presentation::Style) }
      end

    end # Style

  end # Presentation

end # Vedeu
