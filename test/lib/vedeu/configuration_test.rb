require_relative '../../test_helper'
require_relative '../../../lib/vedeu/configuration'

module Vedeu
  describe Configuration do
    describe '#configure' do
      it 'returns an empty collection when no options are set' do
        Configuration.configure([]).must_equal({})
      end

      it 'returns the options which instructs Vedeu to run once' do
        Configuration.configure(['--run-once'])
          .must_equal({ interactive: false })
      end

      it 'returns the options which instructs Vedeu to run in cooked mode' do
        Configuration.configure(['--cooked'])
          .must_equal({ mode: :cooked })
      end

      it 'returns the options which instructs Vedeu to run in raw mode' do
        Configuration.configure(['--raw'])
          .must_equal({ mode: :raw })
      end
    end
  end
end
