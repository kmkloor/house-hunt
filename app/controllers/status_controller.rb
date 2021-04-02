class StatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
      render json: Status.order(id: :desc)
  end

  def seed
    Status.create(status: 'Considering', color: '#EEE8AA')
    Status.create(status: 'Ready For Offer', color: '#90EE90')
    Status.create(status: 'Offer Sent', color: '#4682B4')
  end

end
