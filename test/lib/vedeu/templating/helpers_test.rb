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
          "{{eJx1j08PATEQxR2ki5YQLuJA1hdwnr1MCMmeiXvZIRtrK93Wn/jyqiyJRC+dl9f3m9dqTUF/TQlZgHVKlwJgaTTJo4A2SmN0urGGijsHvs1Sys3EDSpTVisYvHMzr4tyCFxyI7eHvVY2TxQMf59NPyYDgS9aHIrxxB8GbL5yiJ3S9Bex+JgsEnFYYVFzBfwktW/YKMwtIwWdd2z5lAw4nmVmyfn+jsPet+bI0NV4Sj2XRyqRrt7r15HAwKlyA0e/AkXUxSY08JnB1gP9j2kt}}"
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
            "{{eJx1jzGPwjAMhRlQypEUcboJMYDKH4gY3cW6Eyd1BrGnYFBFaVCacKD784SUMiAx2U/P77Pd7WkYrWlLDmBd0F8NsLSG1FHAEJW1psidpfqfA9+UBVVW+kaX2hkN40fuJ+i6bSKfzNXmsDfaVVsNk9ex76fJQGBDyxIxk3I+l5IBW6w8YqcNvUX8Pk2WiizpsDReAT8pEy7s1/ZakobPR2x5lww4nlXpyPuhZsmw2T21dLGB8FGpI7U4f1rzcSow8qqlcwx4FOkXxtDHewYHNz0LZ6E=}}"
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
            "{{eJx1j0sLwjAQhD1IfCQVxZN4UOof8Ly9LIpCz4r3qFspto2kiQ/886apehDMJTtMvtlJs61gtKMjWYBdSrcSYGM0yVxAH6UxOt1bQ+WTAz9kKRVm7gaVKasVjN/c0uvyM7QcuZeH80krWxwVTH6fLb4mA4F1Whw2GLDV1rGJ0vSXXX9NFok4FLMkmbvDomAL/CK1b9gtzSMjBYM3vakkA45XmVlyvr/jsF/vnhq6G5/QKWROVZVKuGr1jyOBLac+6Rx9PIpoiAF0sWKw9wKlIWgJ}}"
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
            "{{eJx1j0sLwjAQhD1IfCSK4kk8KPoHihdhe1kUBc8V71G3UqyNpIkP/POmqXoQzCU7O5mPSbWuoL+lA1mAbUK3HCAymuRZQAelMTrZWUP5kwPfpwllJnCDSpXVCgbv3MLr/DPUXHIn96ejVjY7KBj+Ppt/TQYCS9p6LCaBO9MpA7bcOESsNP1FrL4mC0WRjePZLAhY2NoAv0jtizZz80hJQfedjgrJgONVppac7+/1uFNWGBm6G09oZPLs9hUvXMPy46HAmlMfOkePRxH2sAVNLDLYfgH3e2lq}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{eJx1j0sLwjAQhD1IqiaKohfxoNQ/4Hl7WRSFnhXv0a5SrI2kiQ/886bxBYK5ZIfJtzOp1hT015SQBVindCkAlkaTPApoozRGpxtrqLhz4NsspdxM3KAyZbWCwYubeV28h8CRG7k97LWyeaJg+Pts+jEZCHxui8MKAzZfOXanNP1lFx+TRSIOxXjiD4uaK+AnqX3DRmFuGSnovOhlKRlwPMvMkvP9HYe9b9TI0NX4LfVcHqmsUwpX7/nrSGDg1DuBo49AEXWxCQ0sGWw9ADevaUg=}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{eJx1j71OAzEQhCkiJzk7EESFKEB5Auq5ZgUKUupE6X25BZ1wbpHP5ke8PD4nlwIp3Yxmv9nd0URwu+WaI7Bt+KsD1sGz3RvMyYbgmyoG7n419M413IbHJMRJ9IK7I/ecfTeIcSIru3t/8xLbWnD/f+zpFCoYOrStFhcKarlJ7Kt4Psu+nEJVmh4qZxvoD+vzaUUXfhwLro/YurcKmj6ti4xpJa5Gkc1qcZWHHwJ/h9wybe2eh8p01+Hd0tA4uWGDpkyRKW9ohoJ6hi7/AKgrZ54=}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
