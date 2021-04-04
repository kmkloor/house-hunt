class PropertiesController < ApplicationController
  require 'rubygems'
  require 'mechanize'
  skip_before_action :verify_authenticity_token

  def show
    if(params[:filter])
      @properties = Property.where(status_id: params[:filter]).includes(:status, :notes)
      @statuses = Status.order(id: :desc)
      return
    end
    @properties = Property.where.not(status_id: [4, 5]).includes(:status, :notes).all
    @statuses = Status.order(id: :desc)
  end

  def update
    property = Property.find_by(id: params[:id])
    property.update!(status_id: params[:status_id])
    redirect_to action: 'show', filter: params[:filter]
  end

  def getUrl
    agent = Mechanize.new
    page = agent.get(params[:url])
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
    @property[:url] = params[:url]
    @property.save!
    redirect_to '/'
  end

end
