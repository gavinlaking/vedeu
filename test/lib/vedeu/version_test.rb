require_relative '../../test_helper'

module Vedeu
  describe VERSION do
    let(:klass) { VERSION }

    it { klass.must_be_instance_of(String) }
  end
end
