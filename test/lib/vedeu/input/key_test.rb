require 'test_helper'

module Vedeu

  module Input

    describe Key do

      let(:described) { Vedeu::Input::Key }
      let(:instance)  { described.new(input) { :output } }
      let(:input)     { 'a' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }

        context 'when the required block is not given' do
          subject { described.new(input) }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#input' do
        subject { instance.input }

        it 'returns the key defined' do
          subject.must_equal('a')
        end

        it { instance.must_respond_to(:key) }
      end

      describe '#output' do
        subject { instance.output }

        it 'returns the result of calling the proc' do
          subject.must_equal(:output)
        end

        it { instance.must_respond_to(:action) }
        it { instance.must_respond_to(:press) }
      end

    end # Key

  end # Input

end # Vedeu
