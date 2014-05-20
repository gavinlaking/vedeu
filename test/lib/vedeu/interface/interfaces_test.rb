require_relative '../../../test_helper'

module Vedeu
  describe Interfaces do
    let(:described_class)    { Interfaces }
    let(:instance) { described_class.new }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Interfaces) }

    describe '.default' do
      subject { described_class.default }

      it { subject.must_be_instance_of(Interfaces) }

      it 'adds the dummy interface to the interface list' do
        subject.show.wont_be_empty
      end
    end

    describe '.define' do
      subject { described_class.define }

      it { subject.must_be_instance_of(Interfaces) }
    end

    describe '#add' do
      let(:interface_name)  {}
      let(:klass) { Class }
      let(:options)         { {} }

      subject { instance.add(interface_name, klass, options) }

      it { subject.must_be_instance_of(Hash) }

      it { subject.wont_be_empty }

      context 'when the interface class does not exist' do
        before { Object.stubs(:const_defined?).returns(false) }

        it { proc { subject }.must_raise(UndefinedInterface) }
      end
    end

    describe '#show' do
      subject { instance.show }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#initial' do
      subject { instance.initial }

      it { subject.must_be_instance_of(Array) }
    end

    describe '#main' do
      subject { instance.main }

      it { subject.must_be_instance_of(Array) }
    end
  end
end
