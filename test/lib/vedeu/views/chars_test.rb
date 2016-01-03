# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    describe Chars do

      let(:described)  { Vedeu::Views::Chars }
      let(:instance)   { described.new(collection, parent, _name) }
      let(:collection) { [] }
      let(:parent)     { Vedeu::Views::Stream.new(parent_attributes) }
      let(:_name)      { :vedeu_views_chars }

      let(:parent_attributes) {
        {

        }
      }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '.coerce' do
        subject { described.coerce(collection, parent, _name) }

        context 'when the collection is a Vedeu::Views::Chars' do
          let(:expected) { described.new(collection, parent, _name) }

          it { subject.must_equal(expected) }
        end

        context 'when the collection is an Array' do
          context 'when the collection is empty' do
            let(:collection) { [] }
            let(:expected)   { described.new(collection, parent) }

            it { subject.must_equal(expected) }
          end

          context 'when the collection is not empty' do
            # @todo Add more tests.
          end
        end

        context 'when the collection is a Vedeu::Views::Stream' do
          # @todo Add more tests.
        end

        context 'when the collection is a String' do
          context 'when the collection is empty' do
            let(:collection) { '' }
            let(:expected)   { described.new([], parent) }

            it { subject.must_equal(expected) }
          end

          context 'when the collection is not empty' do
            # @todo Add more tests.
          end
        end

        context 'when the collection is something else' do
          let(:collection) { :invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # Chars

  end # Views

end # Vedeu
