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
          "{{" \
          "eJxdj00LwjAMhj1Ip7aKX3iW+Qd2zi5BUdhZ8d5tUYZzla4VxT9vrTrBXJI34UnetD" \
          "sKxnvKyQJsjSZ5FjBEaYwuUmuofnDgWVlQZSJXqFJZ/QNWXgcOSGV2Omplq1zB7DNd" \
          "Nj0GAt9sEopF5IMBW+8ceVCa/slN02OxSMIWi/s74BepvY1ebe4lKRg1tp1kwPEqS0" \
          "tu7nMSTn+m5oZuxm/pVvJM35XO1fu1WGDg1PcCR38CRTzBPvTwxeDgCdSbXHg=" \
          "}}"
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
            "{{" \
            "eJxdj08LwjAMxT1Ip7aKf8CzzC9QPGaXoCjsrHjvNMpwrlJbUfzy1k4neEpewu/l" \
            "pdnSMNzSnhzA2hpSZwF9VNaaPHOWrk8OfFfkVFrpG11oZ37AIujIA5nanY5Gu3Kv" \
            "YfzZzusZA4EVm8ZiKuVsJiUDttx48qAN/ZOresYSkcYNlnQ3wC/KhBidq30UpGFQ" \
            "x/aSAcebKhz5fahp3K9OTizdbXBol+pMXzufqHorERh59XXnGOxRJCPsQgffDPZe" \
            "Rsda7A==" \
            "}}"
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
            "{{" \
            "eJxdj08LwjAMxT1I/dMqU8GzzC/gOb0ERWFnh/dOMxHnKrUVxS9v1+kEc2lewu/l" \
            "td3VMN7RgRzA1hpSFwERKmvNKXOWbi8OfF+cqLQL3+hCO/MDVkF3PJCp/flotCsP" \
            "Gqaf7bKZMRBYs0ncYsDWqUdybegf2TQzJkUSi3meL3wxOUiBX5UJMfo3+yxIw6iJ" \
            "7SUDjndVOPL78CZxVJ+cWXrY4NAr1YWqBJXwiepvSYEdr77uHIM9CjnBAfSxYnD4" \
            "BqMMW1Q=" \
            "}}"
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
            "{{" \
            "eJxdj0sLwjAQhD1IfCSKD/As+geKF2F7WRQFz4r3VLci1kZiIop/3jXVCuaSzCzf" \
            "7KRaN9Db0p48wNpZ0mcFHdTO2WPiHV2fEuQuO1LuIn6YzHj7A+ZB1xhI9O50sMbn" \
            "ewODz3RWegIUFuxqpMYRn8lEgFhsmEyNpX9yWXoiVm8kTafTKBJxawPyom1o07y6" \
            "R0YGumV7lgIk3nTmiefhXo06xeaho7sLCY1cn9mvBMHFit/FCmusvukSQzyquI8t" \
            "aOKbwfYLqERctQ==" \
            "}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{" \
          "eJxdj08PATEQxR2ki3bFvzjL+gLOs5cJIdkzcS87ZKO2Uq0QX163WIm5dN5MfvNemy" \
          "0Ngy3l5ADW1pA8C+ihtNYUO2fp+uTA96qg0s58o5V25gcsgo48sJP709FoV+Yaxp/t" \
          "vJ4xEPhms6TBgC03HjloQ//Iqp6xVGSJmM5CsTTeAL9IE2J0rvahSEO/ju0lA443qR" \
          "z5fXizZPRzmFi623ClXcozVSkq4VO9v5YKjLz6OnAMFijSIcbQwYrB7gsCxlyT" \
          "}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{" \
          "eJxdj08LwjAMxT1I59b6HzzLPoHn7BIUBc+K926LItZVaiuKX96u6gRveUl+7yXtjo" \
          "bRjkpyABtrSJ4FDFBaa465s3R9cuCFOlJlZ77QSjvzAxZBRx7IZXE6GO2qUsPkM503" \
          "PQYC3+w6bTFgy61H9trQP7JqeiwT9W7W3QK/SBPyk6t9KNIwbO71kgHHm1SOIM61Ki" \
          "EJYp32w/LU0t0Gl7iSZ/pa+nPeP2UCI6++CRwDhSIbYxcSrBnsvQDMNVrp" \
          "}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
