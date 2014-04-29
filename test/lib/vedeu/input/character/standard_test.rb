require_relative '../../../../test_helper'

module Vedeu
  module Input
    module Character
      describe Standard do
        let(:klass) { Standard }
        let(:stream) { [] }

        describe '#parse' do
          subject { klass.parse(stream) }

          it { subject.must_be_instance_of(String) }

          context 'when the stream is empty' do
            it { subject.must_equal("") }
          end

          context 'when the stream contains data' do
            let(:stream) { [13, 13] }

            it 'converts carriage returns to line feeds' do
              subject.must_equal("\n\n")
            end

            it 'converts the stream to UTF-8' do
              subject.encoding.name.must_equal("UTF-8")
            end
          end
        end
      end
    end
  end
end
