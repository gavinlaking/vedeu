require 'test_helper'

module Vedeu

  module Templating

  	describe Encoder do

      let(:described) { Vedeu::Templating::Encoder }
      let(:instance)  { described.new(data) }
      let(:data)      {
        Vedeu::Colour.new(background: '#ff0000', foreground: '#00ff00')
      }
      let(:expected)  {
        "{{eJxj4ci3EgpLTUkttbJyzs/JLy1itxJwSEpMzk4vyi/NS8m3EoPKOsHF2Kx4HJLBaj" \
        "2VeJTT0gyAgM2KzTUEqDMtvygVXacbXIzNmgOkxcAApInNmjMEAAMcJsQ=}}"
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@data').must_equal(data) }
      end

      describe '.process' do
        subject { described.process(data) }

        it { subject.must_equal(expected) }
      end

      describe '#process' do
        it { instance.must_respond_to(:process) }
      end

  	end # Encoder

  end # Templating

end # Vedeu

