require 'test_helper'

module Vedeu

  module Buffers

    describe Refresh do

      let(:described) { Vedeu::Buffers::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Buffers::Refresh' }
      let(:ready)     { true }

      before do
        Vedeu.stubs(:ready?).returns(ready)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        subject { described.by_name(_name) }

        context 'when Vedeu is not yet ready' do
          let(:ready) { false }

          it { subject.must_equal(nil) }
        end

        context 'when Vedeu is ready' do
          context 'when the name is not present' do
            let(:_name) { '' }

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end

          context 'when the name is present' do
            # @todo Add more tests.
            # it { skip }
          end
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Buffers

end # Vedeu
