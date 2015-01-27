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
  basic_auth ENV['GITHUB_USER'], ENV['GITHUB_PASS']


  def initialize
    # ENV["FOO"] is like echo $FOO
    #@auth = {:username => ENV['GITHUB_USER'], :password => ENV['GITHUB_PASS']}
  end

  def follower(screen,options={:query => {:per_page => 100}})
    #options.merge!({:basic_auth => @auth})
    response = self.class.get("/users/#{screen}/followers", options)
    JSON.parse(response.body)
  end

  def user(screen,options={})
    #options.merge!({:basic_auth => @auth})
    self.class.get("/users/#{screen}", options )
  end

  def listgist(screen, options = {})
   #options.merge!({:basic_auth => @auth})
   rep = self.class.get("/users/#{screen}/gists" ,options)
   JSON.parse(rep.body)
  end
  
  def stargist(id, options = {})
    #options.merge!({:basic_auth => @auth})
    self.class.put("/gists/#{id}/star",options)
  end


  def unstargist(id, options = {})
    #options.merge!({:basic_auth => @auth})
    self.class.delete("/gists/#{id}/star", options)
  end

  def rmall(options = {})
    self.class.delete("/gists/f8a0ed7d67e5e16a72a4",options)
  end

def create
  self.class.post()
end


end

#ulgy fucking script
git = Github.new


binding.pry
