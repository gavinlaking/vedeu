require 'test_helper'

module Vedeu

  describe ConveyorStore do

    let(:described) { Vedeu::ConveyorStore }
    let(:instance)  { described.new(storage) }
    let(:storage)   { [] }

    describe 'alias methods' do
      it { instance.must_respond_to(:current) }
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::ConveyorStore) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe '#load' do
      subject { instance.load }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:hydrogen] }

        it { subject.must_equal(:hydrogen) }
      end
    end

    describe '#load_named' do
      let(:_name) {}

      subject { instance.load_named(_name) }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:lithium, :helium, :hydrogen] }

        context 'when the named entry exists' do
          let(:_name) { :helium }

          it { subject.must_equal(:helium) }

          it 'rotates the store to the named entry' do
            instance.storage.must_equal([:lithium, :helium, :hydrogen])
            subject
            instance.storage.must_equal([:helium, :hydrogen, :lithium])
          end
        end

        context 'when the named entry does not exist' do
          let(:_name) { :beryllium }

          it { subject.must_equal(nil) }
        end
      end
    end

    describe '#load_next' do
      subject { instance.load_next }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:lithium, :helium, :hydrogen] }

        it { subject.must_equal(:helium) }

        it 'rotates the store' do
          instance.storage.must_equal([:lithium, :helium, :hydrogen])
          instance.load_next
          instance.load_next
          instance.storage.must_equal([:hydrogen, :lithium, :helium])
        end
      end
    end

    describe '#load_previous' do
      subject { instance.load_previous }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:lithium, :helium, :hydrogen] }

        it { subject.must_equal(:hydrogen) }

        it 'rotates the store' do
          instance.storage.must_equal([:lithium, :helium, :hydrogen])
          instance.load_previous
          instance.load_previous
          instance.storage.must_equal([:helium, :hydrogen, :lithium])
        end
      end
    end

    describe '#save' do
      let(:data)  { :beryllium }
      let(:front) { false }

      subject { instance.save(data, front) }

      context 'when the storage is empty' do
        it { subject.must_equal([:beryllium]) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:lithium, :helium, :hydrogen] }

        context 'and `front` is false' do
          it { subject.must_equal([:beryllium, :lithium, :helium, :hydrogen]) }
        end

        context 'and `front` is true' do
          let(:front) { true }

          it { subject.must_equal([:lithium, :helium, :hydrogen, :beryllium]) }
        end
      end
    end

  end # ConveyorStore

end # Vedeu
