#!/usr/bin/env ruby

require 'httparty'

class User
  def initialize(token = nil, email = nil)
    @token = token
    @email = email
  end

  def process
    save_user_credentials

 #   if validate_user
 #     save_user_credentials
 #   else
 #     puts "ERROR: invalid credentials, try again"
 #   end
  end

  def credentials
    JSON.parse(File.read('user_credentials.json'))
  end

  private

  def validate_user
    response = HTTParty.post(
      'http://localhost:3000/validate.json',
      :headers => {
      'Content-Type' => 'application/json',
      'X-User-Email' => "#{@email}",
      'X-User-Token' => "#{@token}"
      }
    )

    if response["error"]
      return false
    end

    true
  end

  def save_user_credentials
    File.open("user_credentials.json", "w") do |f|
      f.write("{ \"token\": \"#{@token}\", \"email\": \"#{@email}\" }")
    end

    puts "You're all set! Start recording your Dones with 'dst'."
  end
end
