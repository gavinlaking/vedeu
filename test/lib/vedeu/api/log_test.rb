require 'test_helper'

module Vedeu
  module API
    describe Log do
      describe '.logger' do
        it 'logs the message to the $HOME/.vedeu/vedeu.log file' do
          Log.logger.debug('Some message...').must_equal(true)
        end
      end
    end
  end
end
