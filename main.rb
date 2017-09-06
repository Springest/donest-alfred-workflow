#!/usr/bin/env ruby
require_relative 'bundle/bundler/setup'

require 'json'
require_relative './user.rb'
require_relative './done.rb'

class Cli
  def initialize(keyword, query)
    @keyword = keyword
    @query = query

    process_query
  end

  def process_query
    case @keyword
    when "user"
      User.new(@query[0], @query[1]).process
    when "done"
      save_done
    else
      puts "Don't know what to do with this :("
    end
  end

  private

  def user_credentials
    User.new().credentials
  end

  def save_done
    error = "ERROR: Make sure you save your user name via keywords 'dst:user'"
    puts error if user_credentials.empty?

    Done.new(@query, user_credentials)
  end
end

# ENV['keyword'] is defined in each 'args & vars' utility, per keyword input
# ARGV contains the 'query' value per keyword input.

query =
  if ENV["keyword"] != "user"
    ARGV.join(' ')
  else
    ARGV
  end

Cli.new(ENV["keyword"], query)
