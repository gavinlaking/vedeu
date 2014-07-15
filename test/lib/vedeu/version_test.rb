require_relative '../../test_helper'
require_relative '../../../lib/vedeu/version'

module Vedeu
  describe VERSION do
    def subject
      VERSION
    end

    it 'returns a String' do
      subject.must_be_instance_of(String)
    end
  end
end
