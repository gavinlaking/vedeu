require_relative '../../test_helper'
require_relative '../../../lib/vedeu/configuration'

module Vedeu
  describe Configuration do
    let(:args) { [] }

    describe '#initialize' do
      def subject
        Configuration.new(args)
      end

      it 'returns a Configuration instance' do
        subject.must_be_instance_of(Configuration)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@args').must_equal([])
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@options').must_equal({})
      end
    end

    describe '#configure' do
      def subject
        Configuration.configure(args)
      end

      it 'returns a Hash' do
        subject.must_be_instance_of(Hash)
      end

      context 'when the option is --run-once' do
        let(:args) { ['--run-once'] }

        it 'returns the options which instructs Vedeu to run once' do
          subject.must_equal({ interactive: false })
        end
      end
    end
  end
end
