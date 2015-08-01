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
          "{{eJxdj00LwjAMhj1Ip7aKXwjeZP4Bz9klKAo7K7t3GmU4V+laP/DPW+tUMJfkTfokb+sNBeOEdmQBkoyuJcDaaJInAV2UxugstYbKBwe+zTMqzMwVKldWK+hX3MLrwAGp3B4PWtlip2BUTeffHgOBbzYOxXTmgwFbbhy5V5r+ydW3xyIRhzUWtTfAz1J7G63S3HNS0Kter1+SAceLzC25uc9xOPyZmhi6Gb+lWcgTfVY6V++vRQIDpz4XOPoTKKIBtqGFLwY7T83nXwE=}}"
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
            "{{eJxdj00LwjAMhj1I/WgVP0DwJvMPFI/ZJSgKOyveq0YZzlW61g/889ZuevCUvEmeN0m9qWG8pQM5gG1K9wJgbQ2pi4AeKmtNunOWihcHvs9Syq30ic60MxoGFbcIuuGBndqfT0a7/KBhVHXnvxoDgSWbRGIq5WwmJQO23HjyqA39k6tfjcUiiWos7myAX5UJZ7QL+8xIQ7+aXn8kA443lTny/RCTqFeunFh62ODQytWFvnb+ovKtWGDDq687x2CPIh5iB9r4YbD7BjXvXXU=}}"
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
            "{{eJxdj8sKwjAQRV1IqiaKDxDcSf0B19PNoCh0rbiPdirF2kia+MCfN02rC2eTuTOcOzftjoLZgRKyAIeMHiXAzmiSVwFDlMbo7GgNlW8O/JRnVJila1SurFYwbri114EDjvJ0OWtli0TBtNmufjMGAms2DlsM2GbvkFRp+ke2vxmLRByKRZouXbGovwd+k9rH6JXmlZOCUQPtKsmA413mltzev3E4rE/ODT2Nd+gW8kpVgkq4RPW3IoGBU193jt4eRTTBPvSwYnDwAZI0Xd0=}}"
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
            "{{eJxdj8sKwjAQRV1IfCSKDxDcif5AcSNMN4Oi4FrpPupUirWRNPGBP2+aVhfOJnPvcO5M6k0F44hOZAGihB45wM5oklcBPZTG6ORgDeVvDvyYJpSZwDUqVVYrGFTcyuuGAw7yeDlrZbOTglE1Xf48BgJLdjsVs8DVfM6ArfeOjJWmf3Lz81goCiSOF4sgYGFnD/wmtb+mnZtXSgr6FbQrJAOOd5lacnP/bqe9cvPE0NP4hFYmr86veeEOK38XCmw49U3n6ONRhEPsQBsLBrsfqStfPg==}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{eJxdj8sKwjAQRV1IqiaKLwR3Un/A9XQzKApdK+6jHaVYG0kTH/jzprEqOJvMneHMvak3FIy3lJAF2KZ0KwDWRpM8C+iiNEanO2uoeHLg+yyl3MxcozJltYJ+xS28Dhywk/vTUSubJwpG1Xb+nTEQ+GbjsMaALTcOOShN/8jqO2ORiEMxnfliUXsD/CK1j9EqzCMjBb0KWpeSAcerzCy5vX/jcPhzmBi6G3+lmcszlSlK4VK9vxYJDJz6OHD0FiiiAbahhSWDnRf8A18c}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{eJxdj09PAjEQxT2YItuiqAkJN8In8Pz2MtFowhnCvcuOZkPZMd3WP/HL0y0LB2/zZt5v3sz1jWC+5ZojsG34uwPWwbM9GEzJhuCbKgbu/jT0zjXchqdUiJPoBQ8D95L1KAGV3e0/vMS2FsyG6fOlp2DoxK6WVwrqdZOQd/H8H3m79FRpem852UB/Wp/ziy78OhbcD+51LxU0fVkXGeNKXI0ii9XyLpsXgX9C3jJu7YHPK9M5p59KQ6OkzgmaMkWmfKQJCuoZuj0Cs8Jdcg==}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
