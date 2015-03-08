require 'test_helper'

module Vedeu

  describe AssociativeStore do

    let(:described) { Vedeu::AssociativeStore }
    let(:instance)  { described.new(storage) }
    let(:storage)   { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::AssociativeStore) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe '#load' do
      let(:_name) {}

      subject { instance.load(_name) }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { { hydrogen: '1', helium: '2' } }

        context 'when the named entry exists' do
          let(:_name) { :helium }

          it { subject.must_equal('2') }
        end

        context 'when the named entry does not exist' do
          let(:_name) { :beryllium }

          it { subject.must_equal(nil) }
        end
      end
    end

    describe '#save' do
      let(:data)  { [:some_data] }
      let(:_name) {}

      subject { instance.save(data, _name) }

      context 'when a name is given' do
        let(:_name) { :hydrogen }

        it { subject.must_equal({ hydrogen: [:some_data] }) }
      end

      context 'when a name is not given' do
        context 'when the data respond to name' do
          let(:data) { ModelTestClass.new({ name: 'helium' })}

          it { subject.key?('helium').must_equal(true) }
        end

        context 'when the data does not respond to name' do
          it { subject.must_equal({}) }
        end
      end
    end

  end # AssociativeStore

end # Vedeu
