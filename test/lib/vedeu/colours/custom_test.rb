require_relative '../../../test_helper'

module Vedeu
  module Colours
    describe Custom do
      let(:klass)       { Custom }
      let(:colour_name) {}
      let(:html)        {}
      let(:defaults)    {
        {
          normal:  0,
          reverse: 262144,
          black:   0,
          red:     1,
          green:   2,
          yellow:  3,
          blue:    4,
          magenta: 5,
          cyan:    6,
          white:   7,
        }
      }

      describe '#define' do
        before { Colours::Colour.reset }

        subject { klass.define(colour_name, html) }

        context 'when the name is defined' do
          context 'defining red' do
            let(:colour_name) { :html_red }
            let(:html)        { '#ff0000' }

            it 'returns the defined colours' do
              subject.must_equal(defaults.merge!(html_red: 196))
            end
          end

          context 'defining green' do
            let(:colour_name) { :html_green }
            let(:html)        { '#00ff00' }

            it 'returns the defined colours' do
              subject.must_equal(defaults.merge!(html_red: 196, html_green: 46))
            end
          end
        end
      end
    end
  end
end
