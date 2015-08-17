Rails.application.routes.draw do

  # Root of the app
  root 'twilio#index'

  # webhook for Twilio survey number
  match 'ivr/welcome' => 'twilio#ivr_welcome', via: [:get, :post]

  # callback for user entry
  match 'ivr/selection' => 'twilio#get_menu_selection', via: [:get, :post]

  # callback for planet entry
  match 'ivr/planets' => 'twilio#get_planet_selection', via: [:get, :post]

end
