class StatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    
  end

  def seed
    Status.create_with(status: 'Considering', color: '#EEE8AA')
    Status.create_with(status: 'Ready For Offer', color: '#90EE90')
    Status.create_with(status: 'Offer Sent', color: '#4682B4')
  end

end
