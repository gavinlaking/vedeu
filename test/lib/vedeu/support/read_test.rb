require 'test_helper'

module Vedeu

  describe Read do

    let(:described) { Vedeu::Read }
    let(:instance)  { described.new(console, data) }
    let(:console)   { Vedeu::Console.new(height, width) }
    let(:data)      {}
    let(:height)    { 4 }
    let(:width)     { 30 }

    describe '#initialize' do
      subject { instance }

      it { skip; subject.must_be_instance_of(described) }
      it { skip; subject.instance_variable_get('@console').must_equal(console) }
      it { skip; subject.instance_variable_get('@data').must_equal(data) }
    end

    describe '.from' do
      subject { described.from(console, data) }

      it { skip; subject.must_be_instance_of(String) }

      context 'when no data is given' do
        it { skip; subject.must_equal('') }
      end

      context 'when data is given' do
        it { skip; subject.must_equal('') }
      end
    end

  end # Read

end # Vedeu
