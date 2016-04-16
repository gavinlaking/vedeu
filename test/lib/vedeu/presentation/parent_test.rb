# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class PresentationParentTestClass

    include Vedeu::Presentation::Parent

    def initialize(attributes = {})
      @colour = attributes[:colour]
      @parent = attributes[:parent]
    end

  end # PresentationParentTestClass

  module Presentation

    describe Parent do

      let(:described)          { Vedeu::Presentation::Parent }
      let(:included_described) { Vedeu::PresentationParentTestClass }
      let(:included_instance)  { included_described.new(attributes) }
      let(:attributes)         {
        {
          parent: Vedeu::PresentationParentTestClass.new
        }
      }

      describe '#parent' do
        it { included_instance.must_respond_to(:parent) }
      end

    end # Parent

  end # Presentation

end # Vedeu
