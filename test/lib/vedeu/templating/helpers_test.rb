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
          "{{eJxdj0+LwjAQxT1I6poqy7IX8aDUL+B5ehlYXOhNULynOkqxbSSZ+If98sZ0q+BcMsObN7+Xbk/DaEM7cgCbgi4WYMWGVBXDJypmU+SOyf5JkNuyoJrnvtGldkbD+N/3E2bbNpF35mp7PBjt6l2WxLN5KAFisfbaXhtqNA2T9xO/T1FAjA0pSzoilWuQJ2VCgr7lW0kv99KQ9YLiQteP/F4UIPGsSkd+O7xZ8v0KNWW6crj5UauKWoAHNn9Mhxj5qeVJDECU6RfG0MeHBwd3NqRjxg==}}"
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
            "{{eJxdj0GLAjEMhT1Ide0osjfxoIx/oHjMXAKLC3MTVrxXjTI4TqVNXcU/v7Wzo+ApCV/ee0m7a2C0ph15gHVBvw7ghy3pUwJD1My22Hgmd5cgt2VBFavQmNJ4a2D8r/uKs2uaTlBu9PZ4sMZXuzxNZkrN50oJEItVYHtjqWYGJu8W308oIME6KU9bIpMrkGdt4wU9x7eSXuqlJReA5sJUj/sDFCDxoktPYTvWPB3WblOmK0e/j0qfqDEPYfV/2QA7YWqyJMYwlNknJtDDhwb7f4vpYjo=}}"
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
            "{{eJxdTz1vwjAQ7VCZgo2E2BBDq/QPZL4sp1YM2ZBA7AYuVdQkruxzW8Sf5+IAlerF9/Tufdzjk4PFjo4UAXY1/QSADXuyrYEZWmZf7yNTOGvQh6amjnMZXOOid7C86t4TDrdhJMq9PXx+eBe7o4Pn/2tvd1KBwcGtzB4UqNVWtJXzNNBlZl6rKpeniukW9Jf1qcEk8KmhP+e1pyCE5dp1fX8hFWj8tk0k2U5/mc2GpBemX05+48621Af3QIoM9xUGR4JuWRpTGOpijgYm2GtwegEm12KL}}"
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
            "{{eJxFTj0LwkAMdZCqvQ5dxUHRP1BcCnEJiIOboLifmkqx7cldzg/888bTYpa85OXlvW7fwHBPJ/IA+5LuDmDLlnSdQIqa2ZYHz+ReCtSxKqnhTICpjLcGRj/dMsyuBT1RHvTxcrbGN6f1NJllUvN5BNFqJ1xhLP25osjzLIsWagfqqm1wiB0/KzIw/hlsLDkhNJem+eQTMgKFN115kuvQ19P0m2vC9ODwb9DoWvadMCTY5hcUDrEnsLVUGDwxXqSoIMaPFJM3E8dZBA==}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{eJxdT02LwjAQ9SDRNSmIeFk8rNQ/0PP0MigeeltY8R51lGJtJJnsKv5509QP2FwyjzfvY7p9A59r2pEHWJf05wB+2JI+KRiiZrblxjO5mwS5rUqqOQuDqYy3BiYP3SJi9xx6QbnR2+PBGl/vDHz9X5u/SAEKW7ci7QgQy1XQ7o2lli5SNcviE3myAnnWNjYYOL5W9Hb+tuQCobk0ddM/kAIk/urKU9iOf5GO38ZTpgtHz49an6gJb0Ao096YK+wF9MyTGANR5iNUMMBGg8kdnYZjyg==}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{eJx1kD9vAjEMxRlQCneB0oEBdSjiE3R2lghUJLZKRew5zlSnhjNKnALqlycX/kmV2J7z/Hu20+4QjFZYYgBYVbj3AF/s0GwlDLRhdlURGP1fDvnaVljzexRkKTiC1ws3S7W/ik4kC7P++XYU6pLg7X/b9GYKkPqctpi0BIiPZWQ35PAhO7+ZQskGUr0l5Nrz0SJ0C7Il5Dvj0qJZer2HfDr00TBcUd2cGU0R2V9jA6oXyJJYTJ4TNmY8cErv1maL11Fx3/M3KKmfYnWZpQZaqqHuQaabbt0/AcA1bbY=}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
