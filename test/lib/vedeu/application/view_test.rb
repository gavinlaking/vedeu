# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ViewTestClass

    include Vedeu::View

  end # ViewTestClass

  describe View do

    let(:described)          { Vedeu::View }
    let(:included_described) { Vedeu::ViewTestClass }
    let(:included_instance)  { included_described.new }

    describe '#time_now' do
      let(:_time) { Time.new(2015, 6, 23, 22, 25, 17) }

      before { Time.stubs(:now).returns(_time) }

      subject { included_instance.time_now }

      it 'returns a formatted time' do
        subject.must_equal('Tue 23 Jun 22:25')
      end
    end

  end # View

end # Vedeu
