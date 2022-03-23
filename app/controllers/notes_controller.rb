class NotesController < ApplicationController
  wrap_parameters false
  before_action :set_note, only: %i[ show update destroy ]

  def index
    @notes = Note.all

    render json: @notes
  end

  def show
    render json: @note
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(data: note_data_param)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_data_param
    params.require(:note).permit!['data']
  end

  def note_params
    params.require(:note).permit(:id).merge(:data => note_data_param)
  end
end
