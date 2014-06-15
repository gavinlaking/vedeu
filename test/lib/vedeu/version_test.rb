require_relative '../../test_helper'

module Vedeu
  describe VERSION do
    let(:described_class) { VERSION }

    it 'returns a String' do
      described_class.must_be_instance_of(String)
    end
  end
end
