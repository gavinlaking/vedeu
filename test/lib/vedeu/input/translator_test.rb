# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe Translator do

      let(:described) { Vedeu::Input::Translator }
      let(:instance)  { described.new(code) }
      let(:code)      {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@code').must_equal(code) }
      end

      describe '.translate' do
        context 'when the code is not recognised' do
          it { described.translate('a').must_equal('a') }
        end

        context 'when the code is recognised' do
          it { described.translate("\e[H").must_equal(:home) }
        end
      end

      describe '#translate' do
        it { instance.must_respond_to(:translate) }
      end

    end # Translator

  end # Input

end # Vedeu
