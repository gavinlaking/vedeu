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
        lines:    lines
      })
    }
    let(:lines) {
      [
        Line.new([Stream.new('this is the first')]),
        Line.new([Stream.new('this is the second and it is long')]),
        Line.new([Stream.new('this is the third, it is even longer and still truncated')]),
        Line.new([Stream.new('this should not render')]),
      ]
    }

    before { IO.console.stubs(:print) }

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
