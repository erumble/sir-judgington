class EntriesController < ApplicationController

  def index
    @entries = Entry.all
  end

  def new
    @entry = Entry.new
    @contestant = Contestant.new
  end

  def create
    @entry = Entry.create params[:entry]
    redirect_to entries_path
  end
end
