require 'test_helper'

module Vedeu

  module Templating

    describe Encoder do

      let(:described) { Vedeu::Templating::Encoder }
      let(:instance)  { described.new(data) }
      let(:data)      {
        Vedeu::Colours::Colour.new(background: '#ff0000', foreground: '#00ff00')
      }
      let(:expected)  {
        "{{eJxj4ci3kg5LTUkttbJyzs/JLy0qhjHYrQQckhKTs9OL8kvzUjyVeJTT0gyAgM2KzTUEKJeWX5SKkDMwAMmyWbOHAAAseBhK}}"
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

