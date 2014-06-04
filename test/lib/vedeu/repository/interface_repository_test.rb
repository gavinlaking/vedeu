require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Interface) }
    end
  end
end
