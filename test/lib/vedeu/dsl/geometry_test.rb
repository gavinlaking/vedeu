# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class DSLGeometryTestClass

    include Vedeu::DSL::Geometry

  end # DSLGeometryTestClass

  module DSL

    describe Geometry do

      let(:described)          { Vedeu::DSL::Geometry }
      let(:included_described) { Vedeu::DSLGeometryTestClass }

      # describe '#geometry' do
      #   context 'when the required block is not given' do
      #     subject { instance.geometry }

      #     it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
      #   end

      #   context 'when the block is given' do
      #     subject { instance.geometry { } }

      #     context 'when the name is not given' do
      #       it 'uses the name of the model' do
      #         # @todo Add more tests.
      #       end
      #     end

      #     context 'when the name is given' do
      #       # @todo Add more tests.
      #     end
      #   end
      # end

      describe '.included' do
        subject { described.included(included_described) }

        it { subject.must_be_instance_of(Class) }
      end

    end # Geometry

  end # DSL

end # Vedeu
