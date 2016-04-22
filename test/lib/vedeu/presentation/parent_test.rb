# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class PresentationParentTestClass

    include Vedeu::Presentation::Parent

    def initialize(attributes = {})
      @colour = attributes[:colour]
      @name   = attributes[:name]
      @parent = attributes[:parent]
    end

  end # PresentationParentTestClass

  module Presentation

    describe Parent do

      let(:described)          { Vedeu::Presentation::Parent }
      let(:included_described) { Vedeu::PresentationParentTestClass }
      let(:included_instance)  { included_described.new(attributes) }
      let(:parent)             { Vedeu::PresentationParentTestClass.new }
      let(:_name)              { :vedeu_presentation_parent }
      let(:attributes)         {
        {
          name:   _name,
          parent: parent,
        }
      }

      describe '#name' do
        subject { included_instance.name }

        context 'when a name is set' do
          it { subject.must_equal(_name) }
        end

        context 'when a name is not set' do
          let(:_name) {}

          # context 'when a parent name is set' do
          #   it { subject.must_equal('Vedeu::Line') }
          # end

          context 'when a parent name is not set' do
            let(:parent) {}

            it { subject.must_equal(nil) }
          end
        end
      end

      describe '#parent' do
        it { included_instance.must_respond_to(:parent) }
      end

      describe '#parent?' do
        subject { included_instance.parent? }

        context 'when the parent attribute is set' do
          it { subject.must_equal(true) }
        end

        context 'when the parent attribute is not set' do
          let(:parent) {}

          it { subject.must_equal(false) }
        end
      end

    end # Parent

  end # Presentation

end # Vedeu
