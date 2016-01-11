### Vedeu.renders

Also aliased as `Vedeu.render`.

Directly write a view buffer to the terminal. Using this method means
that the refresh event does not need to be triggered after creating
the views, though can be later triggered when needed.

Multiple views can be rendered inside a `renders` block as the example
below shows:

    Vedeu.renders do
      view :some_interface do
        # line do
        #   stream do
        #     left 'Title goes here', width: 35
        #   end
        #   stream do
        #     right Time.now.strftime('%H:%m'), width: 7
        #   end
        # end
      end

      view :other_interface do
        # lines do
        #   line 'This is content for the main interface.'
        #   line ''
        #   line 'Pretty easy eh?'
        # end
      end
    end
