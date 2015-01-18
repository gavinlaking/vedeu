require 'test_helper'

module Vedeu

  describe '.cursor' do
    subject { Vedeu.cursor }

    context 'when there are interfaces are defined' do
    end

    context 'when there are no interfaces defined' do
    end
  end

  describe '.cursors' do
    subject { Vedeu.cursors }

    it { subject.must_be_instance_of(Vedeu::Cursors) }
  end

end # Vedeu
