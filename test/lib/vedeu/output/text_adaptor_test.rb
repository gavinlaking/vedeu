require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/text_adaptor'

module Vedeu
  describe TextAdaptor do
    let(:described_class) { TextAdaptor }
    let(:text)            { '' }

    describe '#initialize' do
      let(:subject) { described_class.new(text) }

      it 'returns an TextAdaptor instance' do
        subject.must_be_instance_of(TextAdaptor)
      end

      it 'sets an instance variable' do
        subject.instance_variable_get('@text').must_equal(text)
      end
    end

    describe '.adapt' do
      let(:subject) { described_class.adapt(text) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      context 'when processing an empty string' do
        let(:text) { '' }

        it 'returns an empty collection' do
          subject.must_be_empty
        end
      end

      context 'when processing a single line' do
        let(:text) { "This is a single line of text.\n" }

        it 'returns a collection of Line objects' do
          subject.first.must_be_instance_of(Line)

          subject.size.must_equal(1)
        end
      end

      context 'when processing multiple lines' do
        let(:text) {
          "Lorem ipsum dolor sit amet,\nConseactetur adipiscing.\n" \
          "Curabitur aliquet, turpis id dui.\n\nConditum elemum.\n"
        }

        it 'returns a collection of Line objects' do
          subject.first.must_be_instance_of(Line)

          subject.size.must_equal(5)
        end
      end
    end
  end
end
