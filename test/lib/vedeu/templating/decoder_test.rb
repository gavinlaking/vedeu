require 'test_helper'

module Vedeu

  module Templating

    describe Decoder do

      let(:described) { Vedeu::Templating::Decoder }
      let(:instance)  { described.new(data) }
      let(:data)      {
        "{{eJxj4ci3kg5LTUkttbJyzs/JLy0qhjHYrQQckhKTs9OL8kvzUvKt5NGVOcEl2ax4HJLBwp5KPMppaQZAwGbF5hoCNCItvygVpxFucEk2aw6QXgMDkG42a84QAEnkMPA=}}"
      }
      let(:expected)  {
        Vedeu::Colours::Colour.new(background: '#ff0000', foreground: '#00ff00')
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

    end # Decoder

  end # Templating

end # Vedeu
