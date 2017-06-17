require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    post_response = self.class.post('/sessions', body: {
        email: email,
        password: password
      })
    @user_auth_token = post_response['auth_token']
    raise "Invalid Email or Password. Try Again." if @user_auth_token.nil?
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @user_auth_token })
    # puts response.body.inspect
    JSON.parse(response.body)
  end

  def get_mentor_availability
      response = self.class.get('/mentors/2299042/student_availability', headers: { "authorization" => @user_auth_token })
      JSON.parse(response.body)
  end




end
