require 'test_helper'

module Vedeu

  describe Compositor do

    let(:described) { Compositor.new(interface, buffer) }
    let(:interface) {
      {
        name: 'indium'
      }
    }
    let(:buffer) {
      Buffer.new({ name: 'indium' })
    }

    before do
      Focus.stubs(:cursor).returns("\e[?25l")
      Terminal.console.stubs(:print)
    end

    describe '#initialize' do
      it { return_type_for(described, Compositor) }
      it { assigns(described, '@interface', interface) }
      it { assigns(described, '@buffer', buffer) }
    end

    describe '#compose' do
      it { return_type_for(described.compose, Array) }
      it { return_value_for(described.compose, [{}]) }
    end

  end # Compositor

end # Vedeu
