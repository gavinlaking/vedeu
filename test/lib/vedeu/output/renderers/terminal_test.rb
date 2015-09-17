require 'test_helper'

module Vedeu

  module Renderers

    describe Terminal do

      let(:described) { Vedeu::Renderers::Terminal }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {
        Vedeu::Models::Page.coerce([
          [
            Vedeu::Models::Cell.new(position: [1, 1]),
            Vedeu::Views::Char.new(value: 'a', position: [1, 2]),
            Vedeu::Models::Cell.new(position: [1, 3]),
          ], [
            Vedeu::Models::Cell.new(position: [2, 1]),
            Vedeu::Views::Char.new(value: 'b', position: [2, 2]),
            Vedeu::Models::Cell.new(position: [2, 3]),
          ], [
            Vedeu::Models::Cell.new(position: [3, 1]),
            Vedeu::Views::Char.new(value: 'c', position: [3, 2]),
            Vedeu::Models::Cell.new(position: [3, 3]),
          ],
        ])
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(Array) }
      end

    end # Terminal

  end # Renderers

end # Vedeu
