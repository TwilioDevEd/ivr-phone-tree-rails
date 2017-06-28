require 'twilio-ruby'
require 'sanitize'


class TwilioController < ApplicationController

  def index
    render text: "Dial Me."
  end

  # POST ivr/welcome
  def ivr_welcome
    response = Twilio::TwiML::VoiceResponse.new
    gather = Twilio::TwiML::Gather.new(num_digits: '1', action: menu_path)
    gather.play(url: "http://howtodocs.s3.amazonaws.com/et-phone.mp3", loop: 3)
    response.append(gather)

    render xml: response.to_s
  end

  # GET ivr/selection
  def menu_selection
    user_selection = params[:Digits]

    case user_selection
    when "1"
      @output = "To get to your extraction point, get on your bike and go down
        the street. Then Left down an alley. Avoid the police cars. Turn left
        into an unfinished housing development. Fly over the roadblock. Go
        passed the moon. Soon after you will see your mother ship."
      twiml_say(@output, true)
    when "2"
      list_planets
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end

  end

  # POST/GET ivr/planets
  # planets_path
  def planet_selection
    user_selection = params[:Digits]

    case user_selection
    when "2"
      twiml_dial("+12024173378")
    when "3"
      twiml_dial("+12027336386")
    when "4"
      twiml_dial("+12027336637")
    else
      @output = "Returning to the main menu."
      twiml_say(@output)
    end
  end

  private

  def list_planets
    message = "To call the planet Broh doe As O G, press 2. To call the planet
    DuhGo bah, press 3. To call an oober asteroid to your location, press 4. To
    go back to the main menu, press the star key."

    response = Twilio::TwiML::VoiceResponse.new
    gather = Twilio::TwiML::Gather.new(num_digits: '1', action: planets_path)
    gather.say(message, voice: 'alice', language: 'en-GB', loop: 3)
    response.append(gather)

    render xml: response.to_xml_str
  end

  def twiml_say(phrase, exit = false)
    # Respond with some TwiML and say something.
    # Should we hangup or go back to the main menu?
    response = Twilio::TwiML::VoiceResponse.new
    response.say(phrase, voice: 'alice', language: 'en-GB')
    if exit
      response.say("Thank you for calling the ET Phone Home Service - the
      adventurous alien's first choice in intergalactic travel.")
      response.hangup
    else
      response.redirect(welcome_path)
    end

    render xml: response.to_xml_str
  end

  def twiml_dial(phone_number)
    response = Twilio::TwiML::VoiceResponse.new
    response.dial(phone_number)

    render xml: response.to_xml_str
  end
end
