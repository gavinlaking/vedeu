require_relative '../../test_helper'

module Vedeu
  describe Buffer do
    let(:klass) { Buffer }

    subject { klass.new }

    it 'returns an instance of self' do
      subject.must_be_instance_of(Vedeu::Buffer)
    end
  end
end
