#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    border do
      title 'Test 1'
    end
    geometry do
      x  4
      y  3
      xn 34
      yn 8
    end
  end

  Vedeu.interface :test2_interface do
    border do
      title 'Test 2'
    end
    geometry do
      x  36
      y  3
      xn 66
      yn 8
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  # vedeu/dsl/stream.rb:16:in `stream': wrong number of arguments (1 for 0)
  Vedeu.render do
    # view(:test1_interface) do
    #   lines do
    #     line do
    #       streams do
    #         stream 'test 1'
    #       end
    #     end
    #   end
    # end

    view(:test2_interface) do
      lines do
        line do
          streams do
            stream do
              text 'v->ls->l->ss->s 1->text 1'
              # below does not render
              text 'v->ls->l->ss->s 1->text 2'
            end
            # below does not render
            stream do
              text 'v->ls->l->ss->s 2->text 1'
              text 'v->ls->l->ss->s 2->text 2'
            end
          end
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start
