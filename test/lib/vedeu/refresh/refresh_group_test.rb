require 'test_helper'

module Vedeu

  describe RefreshGroup do

    let(:described) { Vedeu::RefreshGroup }
    let(:instance)  { described.new(_name) }
    let(:_name)     { 'Vedeu::RefreshGroup' }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
    end

    describe '.by_name' do
      subject { described.by_name(_name) }

      context 'when the name is not present' do
        let(:_name) { '' }

        it { proc { subject }.must_raise(Vedeu::MissingRequired) }
      end

      context 'when the name is present' do
        it {
          Vedeu::RefreshGroup.expects(:by_name).with(_name)
          subject
        }
      end
    end

    describe '#by_name' do
      it { instance.must_respond_to(:by_name) }
    end

  end # RefreshGroup

end # Vedeu
