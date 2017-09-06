#!/usr/bin/env ruby

require 'httparty'

class Done
  attr_reader :description

  def initialize(query, user)
    @description = query
    @user = user
    @date = DateTime.now

    process_done
  end

  def process_done
    if done_saved
      puts "'#{@description}' is saved!"
    else
      puts "Error: unable to save your done."
    end
  end

  private

  def done_saved
    done = {
      :description => @description,
      :date => @date
    }

    response = HTTParty.post(
      #'http://localhost:3000/dones.json',
      'https://donest.herokuapp.com/dones.json',
      :body => { done: done }.to_json,
      :headers => {
        'Content-Type' => 'application/json',
        'X-User-Email' => "#{@user['email']}",
        'X-User-Token' => "#{@user['token']}"
      })

    return false if response["error"]

    true
  end
end
