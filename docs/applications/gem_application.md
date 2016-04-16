# @title Building a gem-based application using Vedeu
# Building a gem-based application using Vedeu

In this tutorial, I hope to guide you through the process of
building a simple application which uses the Vedeu framework as part
of a gem.

We're going to build a Slack bot. This bot will simply relay the
messages sent to a specific channel to your terminal to be displayed.
In a future episode, I might extend this to be able to send messages
back too to demonstrate other aspects of Vedeu, but one step at a
time.

## 1) Create a gem.

Firstly, let's create an empty gem. I'm going to use my name in
underscored form as the name of my bot; he is just a listener (unlike
me as I'm usually quite noisy.)

    bundle gem gavin_laking

Next, we edit the `*.gemspec` file to add `vedeu` and
`simple-slack-bot` as dependencies. You may also what to update other
aspects of the gemspec file here, but I'll leave that with you.

    spec.add_dependency 'vedeu'
    spec.add_dependency 'simple-slack-bot'

Now, run `bundle`, and we should see the 'Bundle complete!' message.

@todo Add more documentation.
