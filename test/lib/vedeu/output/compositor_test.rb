require 'test_helper'

module Vedeu

  describe Compositor do

    let(:described) { Vedeu::Compositor }
    let(:instance)  { described.new(buffer) }
    let(:buffer)    { mock('Buffer') }

    before { buffer.stubs(:geometry) }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Compositor) }
      it { assigns(subject, '@buffer', buffer) }
    end

    describe '#compose' do
      it { skip }
    end

  end # Compositor

end # Vedeu
