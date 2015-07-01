require 'test_helper'

module Vedeu

  describe Cursors do

    let(:described) { Vedeu::Cursors }

    it { described.must_respond_to(:cursors) }

    describe '.cursor' do
      subject { Vedeu.cursor }

      context 'when there are cursors are defined' do
        before do
          Vedeu::Focus.add('Vedeu.cursor')
          Vedeu::Cursor.new(name: 'Vedeu.cursor').store
        end

        it { subject.must_be_instance_of(Vedeu::Cursor) }
      end

      context 'when there are no cursors defined' do
        before do
          Vedeu::Focus.reset
          Vedeu.cursors.reset
        end

        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '.reset!' do
      subject { described.reset! }

      it {
        described.expects(:register).with(Vedeu::Cursor)
        subject
      }
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.cursors.by_name(_name) }

      context 'when the cursor exists' do
        before { Vedeu::Cursor.new(name: _name).store }
        after { Vedeu.cursors.reset }

        it { subject.must_be_instance_of(Vedeu::Cursor) }
        it { subject.name.must_equal('carbon') }
      end

      context 'when the cursor does not exist' do
        let(:_name) { 'nitrogen' }

        it { subject.must_be_instance_of(Vedeu::Cursor) }
        it { subject.name.must_equal('nitrogen') }
      end
    end

  end # Cursors

end # Vedeu
