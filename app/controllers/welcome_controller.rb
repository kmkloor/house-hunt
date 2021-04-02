class WelcomeController < ApplicationController
  require 'rubygems'
  require 'mechanize'
  skip_before_action :verify_authenticity_token

  def index
    
  end

  def getUrl()
    puts params[:url]   
    agent = Mechanize.new
    page = agent.get(params[:url])
    #agent.page.at("some css selector").text
    properties = {}
    puts page.search(".banner h1#main-content .notranslate")[0].inspect
    render json: page.search(".banner h1#main-content .notranslate")[0].children[1].text.split(/, UT /, 2).last
  end

end
