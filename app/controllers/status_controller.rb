class StatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
      render json: Status.order(id: :desc)
  end

  def add
    @status = Status.find_or_initialize_by(status: params[:status])
    return 'existing record' if !@status.new_record? 
    @status[:color] = params[:color]
    @status.save!
  end

  def update
    @status = Status.find_by(id: params[:id])
    @status[:status] = params[:status]
    @status[:color] = params[:color]
    @status.save!
  end

end
