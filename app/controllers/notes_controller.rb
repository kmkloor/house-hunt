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
    redirect_to controller: 'properties', action: 'show', filter: params[:filter]
  end

  def update
    note = Note.find_by(id: params[:id])
    note[:author] = params[:author]
    note[:note] = params[:note]
    note.save!
  end

  def delete 
    Note.where(id: params[:id]).destroy_all
  end

end
