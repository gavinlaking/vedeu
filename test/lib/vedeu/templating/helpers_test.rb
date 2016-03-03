# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Templating

    class HelpersTestClass

      include Vedeu::Templating::Helpers

    end

    describe Helpers do

      let(:described)          { Vedeu::Templating::Helpers }
      let(:included_described) { Vedeu::Templating::HelpersTestClass }
      let(:included_instance)  { included_described.new }

      describe '#background' do
        # let(:expected) {
        #   "{{eJxdjk8LgkAUxDvEGuqhoEt0KOwLeH5eFqLAW5B43/QV0rov1t3+" \
        #   "fPtWy4TmNMNvGGY8IVjkWKIFyCt8NABHo1HUAYS8kBUqE7eOJFlNsP" \
        #   "xWt11ueuPBlJ9Ecb1osqpMo3ATd2LAdpljZ9L4YQSr/4n9D7LES6MR" \
        #   "S/wMfK5EjX0K+U3o7krAG/OSOMwcNDaOCFORar87yFzrLqTFOJml0X" \
        #   "w4tjb4NO3gG3z2TbI=}}"
        # }

        subject { included_instance.background('#000000') { 'background text' } }

        # it { subject.must_equal(expected) }
      end

      describe '#bg' do
        it { included_instance.must_respond_to(:bg) }
      end

      describe '#colour' do
        let(:attributes) { {} }

        subject { included_instance.colour(attributes) { 'colour text' } }

        context 'with no attributes' do
          it { subject.must_be_instance_of(String) }
        end

        # context 'with a background attribute' do
        #   let(:attributes) {
        #     {
        #       background: '#002200'
        #     }
        #   }
        #   let(:expected) {
        #     "{{eJxdjs0KgkAYRVvEGOrCltGisBcYXH5uBqLAXZC4n/QrpNGJ+enn" \
        #     "7Rs1C9rdy7kc7nQmYVFghRagqPGhAY5GIW8CCFkpamwN7ZIU0ioJy8" \
        #     "9023c9Bg8iduLl9aKkbassDjeUJgmlBMgud+wsFQ5Mwupfsf9CknpZ" \
        #     "PCGpn4PPWt7g2EJ246q/EjBtXgJ/moNC7Qg3tWy77w4St7pzYZGm8y" \
        #     "yOhu9rg0/Tyd5Hdkwm}}"
        #   }
        #   let(:expected_decoded) {
        #     Vedeu::Views::Stream.new(
        #       client: nil,
        #       colour: Vedeu::Colours::Colour.coerce(attributes),
        #       name:   nil,
        #       parent: nil,
        #       style:  Vedeu::Presentation::Style.new,
        #       value: 'colour text')
        #   }

        #   it { subject.must_equal(expected) }
        # end

        # context 'with a foreground attribute' do
        #   let(:attributes) {
        #     {
        #       foreground: '#ff0000'
        #     }
        #   }
        #   let(:expected) {
        #     "{{eJxdjrsOwjAMRRlQimiHMiIGUPmBzu4SgRi6IVF1D9RFFWmMkpTH" \
        #     "35O0PCQ8Xfse23c8IZiXWGEHUDZ4NwAHq1G0IUT8JBtUNvWKJHWaYP" \
        #     "FGt31vPiKAmB/F6XLW1KmKYPmPbb4my4I8GTFgu8It1aRxmOdJtK7r" \
        #     "1BXLwgKmXIkWPem7iF+F7qOE3NinxN+LvUbjHGEbUj67M5mjbkJ2mG" \
        #     "azPImH7CuLD+uPvQC3X0x2}}"
        #   }

        #   it { subject.must_equal(expected) }
        # end

        # context 'with both attributes' do
        #   let(:attributes) {
        #     {
        #       background: '#000022',
        #       foreground: '#ff7700',
        #     }
        #   }
        #   let(:expected) {
        #     "{{eJxFjjsLwkAQhC0kSpIirVgo8Q8caQKb5kAs0gmG9KfZSPByK/fw" \
        #     "8e+9xIhbzfANOzNfEqxqbNAB1B0+DcDJahR9BDG/yA6VZYMiSU4TrK" \
        #     "fofvTmJxaQ8LO43K6anGrKNN4xf1kWQHCoPGtJ45+1bZ4zFhRhBSFX" \
        #     "oscynY0u5nehx8aIG/uWSLCZCo8ajSfCdqSGiR4GPvUQ0iErkjJNvh" \
        #     "O3Fl92ePYBmEpC+w==}}"
        #   }

        #   it { subject.must_equal(expected) }
        # end
      end

      describe '#foreground' do
        # let(:expected) {
        #   "{{eJxdTrsOwjAMZEApoh1AYkEMoPIDnd0lAjF0Q6LqHlqDKtIYpQmPvy" \
        #   "cpj0p4uvOdfTccEcwLrNACFDXeW4CD0SiaECJeyhqVSTwiSVYTLD7Wbc" \
        #   "fbLwhgwo+ivJw1WVURLP9tm5/I0iCLBwzYLndHJ9L43mdxtE66YWmYw5" \
        #   "gr0aB3ehbxq9BdlZC35imxj9hrbJ0iTE3Kd3cic66bkBaTdJrFsz5jZf" \
        #   "Bh/MMXxlpNtQ==}}"
        # }

        subject { included_instance.foreground('#000000') { 'foreground text' } }

        # it { subject.must_equal(expected) }
      end

      describe '#fg' do
        it { included_instance.must_respond_to(:fg) }
      end

      # describe '#style' do
      #   let(:expected) {
      #     "{{eJx1j08LgkAQxTuEWUoGnaJD4SfoPHtZigJvQeJ91SmkdSfWtT/fPl" \
      #     "e0IOj2Zt57P2aGLsEiwRxrgKTARwVwMhpF6YHPM1mgMhurSFKtCZZddN" \
      #     "fOVS9cmPFUZNeLplrlBKvf2PZjOmwUhQMHnH3clM6k8W/p8DG7EvNi8H" \
      #     "hlXhJhnJLMYcKVKLH3fH4T2l7Mpl/cUWPV7IQpSNnnmrLTUO5C1sgCNo" \
      #     "/CoCWuDT6NxbwBBzVXlA==}}"
      #   }

      #   subject { included_instance.style(:bold) { 'style text' } }

      #   it { subject.must_equal(expected) }
      # end

    end # ViewHelpers

  end # Templating

end # Vedeu
