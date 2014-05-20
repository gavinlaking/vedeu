require_relative '../../../test_helper'

module Vedeu
  describe Directive do
    let(:described_class)     { Directive }
    let(:instance)  { described_class.new(directive) }
    let(:directive) {}

    it { instance.must_be_instance_of(Directive) }

    describe '.enact' do
      subject { described_class.enact(directive) }

      context 'when the directive is invalid' do
        it 'raises an exception' do
          proc { subject }.must_raise(InvalidDirective)
        end
      end

      context 'when the directive is a collection' do
        let(:directive) { [] }

        context 'and the first element is a number' do
          it 'must be a position' do
            skip
          end
        end

        context 'and the first element is a symbol' do
          it 'must be a colour' do
            skip
          end
        end
      end

      context 'when the directive is individual' do
        let(:directive) { :directive }

        it 'must be a style' do
          skip
        end
      end
    end
  end
end
