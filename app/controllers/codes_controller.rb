require 'oauth2'
require 'net/http'

class CodesController < ApplicationController
  def home


    client = OAuth2::Client.new('506361735862-aibfhtjm31o4nfmhl7j0ci5ls4869dar.apps.googleusercontent.com', 'o7TfyF3sasxmlabTVMGuBA_8', {
      :authorize_url => 'https://accounts.google.com/o/oauth2/auth',
      :token_url => 'https://accounts.google.com/o/oauth2/token'
    })

    access_token = client.auth_code.get_token('4/6eQRxpX50-n3KGpH2FhlQM37MUUZ.UqIT7E4mW5IfmmS0T3UFEsMkAlc0gwI', :redirect_uri => 'http://localhost:3000/code/')

    response_json = access_token.get('https://www.googleapis.com/analytics/v3/management/accounts').body

    @deal_obj = JSON.parse(response_json)


  end
end
