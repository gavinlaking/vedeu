require 'test_helper'

module Vedeu

  module Views

    describe Lines do

      let(:described)  { Vedeu::Views::Lines }
      let(:instance)   { described.new }
      let(:collection) { Vedeu::Views::Lines.new }
      let(:parent)     {}
      let(:_name)      {}

      describe '.coerce' do
        let(:line) { Vedeu::Views::Line.new }

        subject { described.coerce(collection, parent, _name) }

        context 'when the collection is a Vedeu::Views::Lines' do
          it { subject.must_equal(collection) }
        end

        context 'when the collection is an Array' do
          context 'when the collection is not empty' do
            let(:collection) { [line, nil, line] }
            let(:expected)   { described.new([line, line]) }

            it { subject.must_equal(expected) }
          end

          context 'when the collection is empty' do
            let(:collection) { [] }
            let(:expected)   { described.new }

            it { subject.must_equal(expected) }
          end
        end

        context 'when the collection is a Vedeu::Views::Line' do
          let(:collection) { line }
          let(:expected)   { described.new([line]) }

          it { subject.must_equal(expected) }
        end

        context 'when the collection is something else' do
          let(:collection) { :invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # Lines

  end # Views

end # Vedeu
