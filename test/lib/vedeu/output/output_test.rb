require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Output.new(interface) }
    let(:interface) {
      Interface.new({
        name:   'flourine',
        geometry: {
          width:  32,
          height: 3,
        },
        lines:    lines,
        colour:   colour
      })
    }
    let(:lines) {
      [
        {
          streams: [{ text: 'this is the first' }]
        },
        {
          streams: [{ text: 'this is the second and it is long' }]
        },
        {
          streams: [{
            text: 'this is the third, it is even longer and still truncated'
          }]
        },
        {
          streams: [{ text: 'this should not render' }]
        }
      ]
    }
    let(:colour) { {} }

    before do
      IO.console.stubs(:print)
    end

    describe '#initialize' do
      it { return_type_for(described, Output) }
      it { assigns(described, '@interface', interface) }
    end

    describe '.render' do
      subject { Output.render(interface) }

      it { return_type_for(subject, Array) }
    end

  end # Output

end # Vedeu
