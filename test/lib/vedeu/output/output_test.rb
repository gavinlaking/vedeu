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
          streams: [{ text: 'this is the third, it is even longer and still truncated' }]
        },
        {
          streams: [{ text: 'this should not render' }]
        }
      ]
    }
    let(:colour) { {} }

    describe '#initialize' do
      it { return_type_for(described, Output) }
      it { assigns(described, '@interface', interface) }
    end

  end # Output

end # Vedeu
