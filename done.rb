#!/usr/bin/env ruby

require "net/http"
require "uri"

class Done
  attr_reader :description

  def initialize(query, user)
    @description = query
    @user = user
    @date = Time.now

    process_done
  end

  def process_done
    if done_saved
      puts "#{@description} is saved!"
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

    response = Net::HTTP.post(
      #URI("http://localhost:3000/dones.json"),
      URI("https://donest.herokuapp.com/dones.json"),
      done.to_json,
      "Content-Type" => "application/json",
      "X-User-Email" => "#{@user["email"]}",
      "X-User-Token" => "#{@user["token"]}"

    )

    return false if response["error"]

    true
  end
end
