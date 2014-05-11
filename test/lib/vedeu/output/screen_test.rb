require_relative '../../../test_helper'

module Vedeu
  describe Screen do
    let(:klass)    { Screen }
    let(:instance) { klass.new }
    let(:block)    {}

    subject { instance }

    it { subject.must_be_instance_of(Vedeu::Screen) }

    describe '.default' do
      subject { klass.default }

      it { subject.must_be_instance_of(Screen) }

      it 'adds the dummy interface to the interface list' do
        subject.show.wont_be_empty
      end
    end

    describe '#add' do
      let(:interface_name)  {}
      let(:interface_klass) { Class }
      let(:options)         { {} }

      subject { instance.add(interface_name, interface_klass, options) }

      it { subject.must_be_instance_of(Hash) }

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
