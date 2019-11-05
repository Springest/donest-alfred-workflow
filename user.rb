#!/usr/bin/env ruby

class User
  def initialize(token = nil, email = nil)
    @token = token
    @email = email
  end

  def process
    save_user_credentials
  end

  def credentials
    JSON.parse(File.read('user_credentials.json'))
  end

  private

  def save_user_credentials
    File.open("user_credentials.json", "w") do |f|
      f.write("{ \"token\": \"#{@token}\", \"email\": \"#{@email}\" }")
    end

    puts "You're all set! Start recording your Dones with 'dst'."
  end
end
