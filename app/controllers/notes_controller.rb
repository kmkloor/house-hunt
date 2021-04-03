class NotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def all
    render json: Note.all
  end

  def add
    if(params[:note])
      Note.create(
        author: params[:author],
        note: params[:note],
        property_id: params[:id]
      ) 
    end
    redirect_to '/properties/show'
  end

  def delete 
    Note.where(id: params[:id]).destroy_all
  end

end
