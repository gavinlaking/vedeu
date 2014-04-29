require_relative '../../../test_helper'

module Vedeu
  module Input
    describe Translator do
      let(:klass) { Translator }
      let(:key)   {}

      describe '.press' do
        subject { klass.press(key) }

        it { subject.must_be_instance_of(NilClass) }
      end
    end
  end
end
