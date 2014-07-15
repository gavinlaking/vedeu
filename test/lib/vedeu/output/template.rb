require_relative '../../../test_helper'

module Vedeu
  describe Template do
    describe '#parse' do
      object = OpenStruct.new(value: 'Hello from variable!')

      it 'parses the template when the template file was found' do
        path   = '/../../../test/support/template.erb'
        Template.new(object, path).parse.must_match(/This is the test template/)
        Template.new(object, path).parse.must_match(/Hello from variable!/)
      end

      it 'raises an exception when the template file cannot be found' do
        path   = '/some/wrong/path/template.erb'
        proc { Template.new(object, path).parse }.must_raise(Errno::ENOENT)
      end
    end
  end
end
