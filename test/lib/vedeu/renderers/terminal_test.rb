require 'test_helper'

module Vedeu

  module Renderers

    describe Terminal do

      let(:described) { Vedeu::Renderers::Terminal }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:_name)     {}
      let(:output)    {
        Vedeu::Models::Page.coerce([
          [
            Vedeu::Models::Cell.new(position: [1, 1]),
            Vedeu::Views::Char.new(name: _name, value: 'a', position: [1, 2]),
            Vedeu::Models::Cell.new(position: [1, 3]),
          ], [
            Vedeu::Models::Cell.new(position: [2, 1]),
            Vedeu::Views::Char.new(name: _name, value: 'b', position: [2, 2]),
            Vedeu::Models::Cell.new(position: [2, 3]),
          ], [
            Vedeu::Models::Cell.new(position: [3, 1]),
            Vedeu::Views::Char.new(name: _name, value: 'c', position: [3, 2]),
            Vedeu::Models::Cell.new(position: [3, 3]),
          ],
        ])
      }

      before do
        Vedeu::Terminal.stubs(:output).returns(output)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        before { Vedeu::Terminal.stubs(:clear) }

        subject { instance.clear }

        it do
          Vedeu::Terminal.expects(:clear)
          subject
        end
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(Vedeu::Models::Page) }
      end

    end # Terminal

  end # Renderers

end # Vedeu
