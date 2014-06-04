require_relative '../../../test_helper'

module Vedeu
  describe CommandRepository do
    let(:described_class) { CommandRepository }

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Command) }
    end
  end
end
