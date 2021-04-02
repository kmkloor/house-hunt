class PropertiesController < ApplicationController
  require 'rubygems'
  require 'mechanize'
  skip_before_action :verify_authenticity_token

  def add
  end

  def show
    if(params[:status_id])
    property = Property.find_by(id: params[:id])
    property.update!(status_id: params[:status_id])
    end
    if(params[:filter])
      @properties = Property.where(status_id: params[:filter]).includes(:status, :notes)
      @statuses = Status.order(id: :desc)
      return
    end
    if(params[:note])
      Note.create(
        author: params[:author],
        note: params[:note],
        property_id: params[:id]
      ) 
    end
    @properties = Property.includes(:status, :notes).all
    @statuses = Status.order(id: :desc)
  end

  def edit
    @property = Property.find_by(id: params[:id])
  end

  def update
    puts params.inspect
    property = Property.find_by(id: params[:id])
    property.update!(status_id: params[:status_id])
    @properties = Property.includes(:status).all
    @statuses = Status.order(id: :desc)
    render :show
  end

  def getUrl()
    puts params[:url]   
    agent = Mechanize.new
    page = agent.get(params[:url])
    #agent.page.at("some css selector").text
    url_details = {}
    page.search(".details-block-full-property-details li").each do |li|
      url_details[li.children[0].text.gsub!(': ', '')] = li.children[1].text[1..-1]
    end
    @property = Property.find_or_initialize_by(mls_id: url_details['MLS ID'].to_i)
    return 'existing record' if !@property.new_record? 
    h1_banner = page.search(".banner h1#main-content .notranslate")[0]
    @property[:address] = h1_banner.children[0].text.gsub!(',', '')
    @property[:city] = h1_banner.children[1].text.split(/, UT /, 2).first
    @property[:zip] = h1_banner.children[1].text.split(/, UT /, 2).last
    @property[:img_url] = page.search(".fancybox-thumb")[0].attributes["src"].value || nil
    @property[:price] = url_details['Price'].gsub(/[^\d\.]/, '').to_f
    @property[:square_feet] = url_details['Square Feet'].gsub(/[^\d\.]/, '').to_i
    @property[:lot_size] = url_details['Lot Size (Acres)'].to_f
    @property[:year_built] = url_details['Year Built'].to_i
    @property[:status_id] = 1
    @property.save!
  end

end
