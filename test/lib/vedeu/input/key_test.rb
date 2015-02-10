require 'test_helper'

module Vedeu

  describe Key do

    let(:described) { Vedeu::Key }
    let(:instance)  { described.new(input) { :output } }
    let(:input)     { 'a' }

    describe '.define' do
      subject { described.define(input) { :output } }

      it { subject.must_be_instance_of(Key) }

      context 'when the required block is not given' do
        subject { described.define(input) }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end
    end

    describe '#initialize' do
      subject { instance }

      it { instance.must_be_instance_of(Key) }
      it { instance.instance_variable_get('@input').must_equal(input) }

      context 'when the required block is not given' do
        subject { described.new(input) }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end
    end

    describe '#input' do
      subject { instance.input }

      it 'returns the key defined' do
        subject.must_equal('a')
      end

      context 'alias method #key' do
        subject { instance.key }

        it { subject.must_equal('a') }
      end
    end

    describe '#output' do
      subject { instance.output }

      it 'returns the result of calling the proc' do
        subject.must_equal(:output)
      end

      context 'alias method #action' do
        subject { instance.action }

        it { subject.must_equal(:output) }
      end

      context 'alias method #press' do
        subject { instance.press }

        it { subject.must_equal(:output) }
      end
    end

  end # Key

end # Vedeu
