require_relative '../../../test_helper'

module Vedeu
  describe Template do
    let(:described_class) { Template }
    let(:object)          { stub(value: 'Hello from variable!') }
    let(:path)            { '/../../../test/support/template.erb' }

    describe '#parse' do
      let(:subject) { described_class.new(object, path).parse }

      context 'when the template file can be found' do
        it 'parses the template' do
          subject.must_match(/This is the test template/)
          subject.must_match(/Hello from variable!/)
        end
      end

      context 'when the template file cannot be found' do
        let(:path) { '/some/wrong/path/template.erb' }

        it 'raises an exception' do
          proc { subject }.must_raise(Errno::ENOENT)
        end
      end
    end
  end
end
