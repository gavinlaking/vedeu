require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    describe '.borders' do
      subject { described.borders }

      it { subject.must_be_instance_of(described) }
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.borders.by_name(_name) }

      context 'when the border exists' do
        before do
          Vedeu.border 'carbon' do
          end
        end
        after { Vedeu.borders.reset }

        it { subject.must_be_instance_of(Vedeu::Border) }
      end

      context 'when the border does not exist' do
        let(:_name) { 'nitrogen' }

        it { subject.must_be_instance_of(Vedeu::NullBorder) }
      end
    end

  end # Borders

end # Vedeu
