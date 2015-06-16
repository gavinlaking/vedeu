require 'test_helper'

module Vedeu

  module Templating

    class HelpersTestClass

      include Vedeu::Templating::Helpers

    end

    describe Helpers do

      let(:described) { Vedeu::Templating::Helpers }
      let(:instance)  { Vedeu::Templating::HelpersTestClass.new }

      describe '#background' do
        subject { instance.background('#000000') { 'background text' } }
      end

      describe '#colour' do
        let(:attributes) {}

        subject { instance.colour(attributes) { 'colour text' } }
      end

      describe '#foreground' do
        subject { instance.foreground('#000000') { 'foreground text' } }
      end

    end # Helpers

  end # Templating

end # Vedeu
