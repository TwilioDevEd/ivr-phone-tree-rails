<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# IVR Phone Tree with Ruby on Rails and Twilio

![](https://github.com/TwilioDevEd/ivr-phone-tree-rails/actions/workflows/build.yml/badge.svg)

IVRs (interactive voice response) are automated phone systems that can
facilitate communication between callers and businesses. If you've ever dialed
your credit card company to check on a balance after responding to a series of
automated prompts, you've used an IVR. Learn how to build an IVR in minutes
using Twilio's powerful TwiML API.


[Read the full tutorial here!](https://www.twilio.com/docs/howto/walkthrough/ivr-phone-tree/ruby/rails)

## Local Development

This project is built using [Ruby on Rails](http://rubyonrails.org/) Framework.

To run this locally on your machine.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git@github.com:TwilioDevEd/ivr-phone-tree-rails.git
   $ cd ivr-phone-tree-rails
   ```

1. Install the dependencies.

   ```bash
   $ bundle install
   ```

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rails test
   ```

1. Start the server.

   ```bash
   $ bundle exec rails s
   ```

1. Check it out at [http://localhost:3000](http://localhost:3000).

## How to Demo

1. Expose the application to the wider Internet using [ngrok](https://ngrok.com/).

   ```bash
   $ ngrok http 3000
   ```
   
1. Provision a number under the
   [Manage Numbers page](https://www.twilio.com/console/phone-numbers/incoming)
   on your account. Set the voice URL for the number to
   `http://<your-ngrok-subdomain>.ngrok.io/ivr/welcome`.

1. Grab your phone and call your newly-provisioned number!

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](LICENSE)
* Lovingly crafted by Twilio Developer Education.
