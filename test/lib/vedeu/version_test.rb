require_relative '../../test_helper'

module Vedeu
  describe VERSION do
    let(:described_class) { VERSION }

    it { described_class.must_be_instance_of(String) }
  end
end
