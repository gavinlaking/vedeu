require 'test_helper'

module Vedeu

  describe Carousel do

    let(:described) { Carousel.new(storage) }
    let(:storage)   { [] }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::Carousel) }
      it { assigns(described, '@storage', storage) }
    end

    describe '#add' do
      let(:focus) { false }

      before { described.reset }

      subject { described.add('thallium', focus) }

      it 'adds an element to storage' do
        subject.all.must_equal(['thallium'])
      end

      context 'when the element already exists' do
        let(:storage) { ['thallium'] }

        it 'does not add it again' do
          subject.all.must_equal(['thallium'])
        end

        context 'but focus is true' do
          let(:focus) { true }

          it 'does not add it again' do
            subject.all.must_equal(['thallium'])
          end
        end
      end

      context 'when focus is true' do
        let(:storage) { ['lead'] }
        let(:focus) { true }

        it 'adds the element to storage and makes it current' do
          subject.current.must_equal('thallium')
        end
      end

      context 'when focus is false' do
        let(:storage) { ['lead'] }
        let(:focus) { false }

        it 'adds the element to storage and leaves the current element' do
          subject.current.must_equal('lead')
        end
      end
    end

    describe '#by_element' do
      let(:storage) { ['thallium', 'lead', 'bismuth'] }

      subject { described.by_element(element) }

      context 'when the element exists' do
        let(:element) { 'lead' }

        it 'the named element is made current when the method is called' do
          subject.current.must_equal('lead')
        end
      end

      context 'when the element does not exist' do
        let(:element) { 'not_found' }

        it { proc { subject }.must_raise(ModelNotFound) }
      end
    end

    describe '#current' do
      let(:storage) { ['thallium', 'lead', 'bismuth'] }

      subject { described.current }

      it 'returns the name of the current element' do
        subject.must_equal('thallium')
      end

      context 'when there are no elements defined' do
        let(:storage) { [] }

        it { return_type_for(subject, NilClass) }
      end
    end

    describe '#current?' do
      before { described.stubs(:current).returns('lead') }

      context 'when the element is current' do
        it { described.current?('lead').must_equal(true) }
      end

      context 'when the element is not current' do
        it { described.current?('bismuth').must_equal(false) }
      end
    end

    describe '#each' do
      let(:storage) { ['thallium', 'lead', 'bismuth'] }

      subject {
        described.each do |element|
          # ...
        end
      }

      it { subject.must_equal(['thallium', 'lead', 'bismuth']) }

      context 'without a block given' do
        subject { described.each }

        it { return_type_for(subject, Enumerator) }
      end
    end

    describe '#next_item' do
      let(:storage) { ['thallium', 'lead', 'bismuth'] }

      subject { described.next_item }

      it 'the next element is made current when the method is called' do
        subject.current.must_equal('lead')
      end

      context 'when the storage is empty' do
        let(:storage) { [] }

        it { return_type_for(subject, Carousel) }
      end
    end

    describe '#prev_item' do
      let(:storage) { ['thallium', 'lead', 'bismuth'] }

      subject { described.prev_item }

      it 'the previous element is made current when the method is called' do
        subject.current.must_equal('bismuth')
      end

      context 'when the storage is empty' do
        let(:storage) { [] }

        it { return_type_for(subject, Carousel) }
      end
    end

  end # Carousel

end # Vedeu
