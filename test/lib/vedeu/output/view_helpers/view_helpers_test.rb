require 'test_helper'

module Vedeu

  class ViewHelpersTestClass

    include Vedeu::ViewHelpers

  end

  describe ViewHelpers do

    let(:described) { ViewHelpers }
    let(:instance)  { ViewHelpersTestClass.new }

    describe '#time_now' do
      let(:_time) { Time.new(2015, 6, 23, 22, 25, 17) }

      before { Time.stubs(:now).returns(_time) }

      subject { instance.time_now }

      it 'returns a formatted time' do
        subject.must_equal('Tue 23 Jun 22:25')
      end
    end

  end # ViewHelpers

end # Vedeu
