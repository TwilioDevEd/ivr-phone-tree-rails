require 'twilio-ruby'
require 'sanitize'


class TwilioController < ApplicationController
  before_action :set_caller_information, only: [:connect_ivr]
  protect_from_forgery except: [:get_answer]
  
  def index
    render text: "Dial Me."
  end

  # POST ivr/welcome
  def ivr_welcome
    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: '1', action: '/ivr/selection' do |g|
        g.Play "http://howtodocs.s3.amazonaws.com/et-phone.mp3", loop: 3
      end
    end
    render text: response.text
  end

  # POST ivr/selection
  def get_menu_selection
    user_selection = params[:Digits]

    case user_selection
    when "1"
      @output = "To get to your extraction point, get on your bike and go down
        the street. Then Left down an alley. Avoid the police cars. Turn left
        into an unfinished housing developement. Fly over the roadblock. Go
        passed the moon. Soon after you will see your mother ship."
      twiml_say(@output, true)
    when "2"
      list_planets
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end

  end

  def list_planets
    message = "To call the planet Broh doe As O G, press 2. To call the planet
    DuhGo bah, press 3. To call an oober asteroid to your location, press 4. To
    go back to the main menu, press the star key."

    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: '1', action: '/ivr/planets' do |g|
        g.Say message, voice: 'alice', language: 'en-GB', loop:3
      end
    end

    render text: response.text
  end

  # POST ivr/planets
  def get_planet_selection
    user_selection = params[:Digits]

    case user_selection
    when "2"
      @output = "http://howtodocs.s3.amazonaws.com/brodo-selection.mp3"
      twiml_play(@output, true)
    when "3"
      @output = "http://howtodocs.s3.amazonaws.com/dugobah-selection.mp3"
      twiml_play(@output, true)
    when "4"
      @output = "http://howtodocs.s3.amazonaws.com/uber-selection.mp3"
      twiml_play(@output, true)
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end
  end

  private

  def twiml_say(phrase, exit = false)
    # Respond with some TwiML and say something.
    # Should we hangup or go back to the main menu?
    response = Twilio::TwiML::Response.new do |r|
      r.Say phrase, voice: 'alice', language: 'en-GB'
      if exit 
        r.Hangup 
      else
        r.Redirect "/ivr/welcome"
      end
    end

    render text: response.text
  end

  def twiml_play(audio_url, exit = false)
    # Respond with some TwiML and say something.
    # Should we hangup or go back to the main menu?
    response = Twilio::TwiML::Response.new do |r|
      r.Play audio_url, loop:2
      if exit 
        r.Hangup 
      else
        r.Redirect "/ivr/welcome"
      end
    end

    render text: response.text
  end

  def set_caller_information
    # Get phone_number from the incoming GET request from Twilio
    @phone_number = Sanitize.clean(params[:From])
  end
end