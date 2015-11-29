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
        let(:expected) {
          "{{eJxdjk8LgkAUxDvEGuqhoEt0KOwLeH5eFqLAW5B43/QV0rov1t3+fPtWy4TmNMNvGGY8IVjkWKIFyCt8NABHo1HUAYS8kBUqE7eOJFlNsPxWt11ueuPBlJ9Ecb1osqpMo3ATd2LAdpljZ9L4YQSr/4n9D7LES6MRS/wMfK5EjX0K+U3o7krAG/OSOMwcNDaOCFORar87yFzrLqTFOJml0Xw4tjb4NO3gG3z2TbI=}}"
        }

        subject { instance.background('#000000') { 'background text' } }

        it { instance.must_respond_to(:bg) }

        it { subject.must_equal(expected) }
      end

      describe '#colour' do
        let(:attributes) { {} }

        subject { instance.colour(attributes) { 'colour text' } }

        context 'with no attributes' do
          it { subject.must_be_instance_of(String) }
        end

        context 'with a background attribute' do
          let(:attributes) {
            {
              background: '#002200'
            }
          }
          let(:expected) {
            "{{eJxdjs0KgkAYRVvEGOrCltGisBcYXH5uBqLAXZC4n/QrpNGJ+enn7Rs1C9rdy7kc7nQmYVFghRagqPGhAY5GIW8CCFkpamwN7ZIU0ioJy89023c9Bg8iduLl9aKkbassDjeUJgmlBMgud+wsFQ5Mwupfsf9CknpZPCGpn4PPWt7g2EJ246q/EjBtXgJ/moNC7Qg3tWy77w4St7pzYZGm8yyOhu9rg0/Tyd5Hdkwm}}"
          }
          let(:expected_decoded) {
            Vedeu::Views::Stream.new(
              client: nil,
              colour: Vedeu::Colours::Colour.coerce(attributes),
              name:   '',
              parent: nil,
              style:  Vedeu::Presentation::Style.new,
              value: 'colour text')
          }

          it { subject.must_equal(expected) }
        end

        context 'with a foreground attribute' do
          let(:attributes) {
            {
              foreground: '#ff0000'
            }
          }
          let(:expected) {
            "{{eJxdjrsOwjAMRRlQimiHMiIGUPmBzu4SgRi6IVF1D9RFFWmMkpTH35O0PCQ8Xfse23c8IZiXWGEHUDZ4NwAHq1G0IUT8JBtUNvWKJHWaYPFGt31vPiKAmB/F6XLW1KmKYPmPbb4my4I8GTFgu8It1aRxmOdJtK7r1BXLwgKmXIkWPem7iF+F7qOE3NinxN+LvUbjHGEbUj67M5mjbkJ2mGazPImH7CuLD+uPvQC3X0x2}}"
          }

          it { subject.must_equal(expected) }
        end

        context 'with both attributes' do
          let(:attributes) {
            {
              background: '#000022',
              foreground: '#ff7700',
            }
          }
          let(:expected) {
            "{{eJxFjjsLwkAQhC0kSpIirVgo8Q8caQKb5kAs0gmG9KfZSPByK/fw8e+9xIhbzfANOzNfEqxqbNAB1B0+DcDJahR9BDG/yA6VZYMiSU4TrKfofvTmJxaQ8LO43K6anGrKNN4xf1kWQHCoPGtJ45+1bZ4zFhRhBSFXoscynY0u5nehx8aIG/uWSLCZCo8ajSfCdqSGiR4GPvUQ0iErkjJNvhO3Fl92ePYBmEpC+w==}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{eJxdTrsOwjAMZEApoh1AYkEMoPIDnd0lAjF0Q6LqHlqDKtIYpQmPvycpj0p4uvOdfTccEcwLrNACFDXeW4CD0SiaECJeyhqVSTwiSVYTLD7WbcfbLwhgwo+ivJw1WVURLP9tm5/I0iCLBwzYLndHJ9L43mdxtE66YWmYw5gr0aB3ehbxq9BdlZC35imxj9hrbJ0iTE3Kd3cic66bkBaTdJrFsz5jZfBh/MMXxlpNtQ==}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{eJx1j08LgkAQxTuEWUoGnaJD4SfoPHtZigJvQeJ91SmkdSfWtT/fPle0IOj2Zt57P2aGLsEiwRxrgKTARwVwMhpF6YHPM1mgMhurSFKtCZZddNfOVS9cmPFUZNeLplrlBKvf2PZjOmwUhQMHnH3clM6k8W/p8DG7EvNi8HhlXhJhnJLMYcKVKLH3fH4T2l7Mpl/cUWPV7IQpSNnnmrLTUO5C1sgCNo/CoCWuDT6NxbwBBzVXlA==}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
