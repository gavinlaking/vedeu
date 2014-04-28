require_relative '../../test_helper'

module Vedeu
  describe Cell do
    let(:klass)    { Cell }
    let(:data)     { :some_value }
    let(:instance) { klass.new(data) }

    it { instance.must_be_instance_of(Cell) }

    describe '#first' do
      subject { instance.first }

      it 'returns the value from the cell' do
        subject.must_equal(:some_value)
      end
    end
  end
end
