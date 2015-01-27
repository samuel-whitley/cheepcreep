require "cheepcreep/version"
require "cheepcreep/init_db"
require "httparty"
require "pry"

module Cheepcreep
  class GitHubUser < ActiveRecord::Base
  end
end

class Github
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize
    # ENV["FOO"] is like echo $FOO
    @auth = {:username => ENV['GITHUB_USER'], :password => ENV['GITHUB_PASS']}
  end

  def follower(screen,options={})
    options.merge!({:basic_auth => @auth})
    response = self.class.get("/users/#{screen}/followers", options)
  end

  def user(screen,options={})
    options.merge!({:basic_auth => @auth})
    self.class.get("/users/#{screen}")
  end

end

#ulgy fucking script
git = Github.new
toy = git.follower 'redline6561'
giggles = JSON.parse(toy.body)
giggles.each do |x|
x.values_at('login').each do |y|
Cheepcreep::GitHubUser.create(:login => y)
  end
end




binding.pry
