# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Output

    describe CompressorCache do

      let(:described) { Vedeu::Output::CompressorCache }
      let(:empty)     {
        {
          compressed: '',
          original:   [],
        }
      }

      before { described.reset! }

      describe '#cache' do
        subject { described.cache(content, compression) }

        context 'when the content is empty' do
          context 'when compression is enabled' do
            # @todo Write more tests.
          end

          context 'when compression is not enabled' do
            # @todo Write more tests.
          end
        end

        context 'when the content is not empty' do
          context 'when compression is enabled' do
            # @todo Write more tests.
          end

          context 'when compression is not enabled' do
            # @todo Write more tests.
          end
        end
      end

      # describe '#read' do
      #   let(:key) {}

      #   subject { described.read(key) }

      #   context 'when the key is nil' do
      #     it { subject.must_equal([]) }
      #   end

      #   context 'when the key is not :compressed or :original' do
      #     let(:key) { :invalid }

      #     it { subject.must_equal([]) }
      #   end

      #   context 'when the key is :compressed' do
      #     let(:key) { :compressed }

      #     context 'when there is no compressed data stored' do
      #       it { subject.must_equal('') }
      #     end

      #     context 'when there is compressed data stored' do
      #       before { described.write(:compressed, 'compressed_data') }

      #       it { subject.must_equal('compressed_data') }
      #     end
      #   end

      #   context 'when the key is :original' do
      #     let(:key) { :original }

      #     context 'when there is no original data stored' do
      #       it { subject.must_equal([]) }
      #     end

      #     context 'when there is original data stored' do
      #       before { described.write(:original, [:original_data]) }

      #       it { subject.must_equal([:original_data]) }
      #     end
      #   end
      # end

      # describe '#write' do
      #   let(:key)    {}
      #   let(:_value) {}

      #   subject { described.write(key, _value) }

      #   context 'when the key is invalid' do
      #     context 'when the key is nil' do
      #       it { subject.must_equal(empty) }
      #     end

      #     context 'when the key is invalid' do
      #       let(:key) { :invalid }

      #       it { subject.must_equal(empty) }
      #     end
      #   end

      #   context 'when the key is valid' do
      #     let(:key) { :compressed }

      #     context 'when the value is nil' do
      #       it { subject.must_equal(empty) }
      #     end

      #     context 'when the value is empty' do
      #       let(:_value) { [] }

      #       it { subject.must_equal(empty) }
      #     end

      #     context 'when the value is not nil or empty' do
      #       let(:_value)   { 'compressed_data' }
      #       let(:expected) {
      #         {
      #           compressed: 'compressed_data',
      #           original:   [],
      #         }
      #       }

      #       it { subject.must_equal(expected) }
      #     end
      #   end
      # end

    end # CompressorCache

  end # Output

end # Vedeu
