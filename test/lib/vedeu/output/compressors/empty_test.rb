require 'test_helper'

module Vedeu

  module Output

    module Compressors

      describe Empty do

        let(:described) { Vedeu::Output::Compressors::Empty }
        let(:instance)  { described.new(content) }
        let(:content)   {}

        describe '.with' do
          it { described.must_respond_to(:with) }
        end

        describe '#initialize' do
          it { instance.must_be_instance_of(described) }
          it { instance.instance_variable_get('@content').must_equal(content) }
        end

        describe '#compress' do
          subject { instance.compress }

          it { instance.must_respond_to(:compress) }

          # @todo Add more tests.
        end

      end # Empty

    end # Compressors

  end # Output

end # Vedeu
