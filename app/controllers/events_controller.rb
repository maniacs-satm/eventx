class EventsController < ApplicationController
  layout 'templates/green/index', only: [:show]
  before_action :set_events, :only => [:show]
  def new
    @events = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    
  end

  def create
    @events = Event.new(event_params)
    # 2.times {@events.tickets.build}
    # @events.image = image.secure_url
    if @events.save
      respond_to do |format|
        format.html {redirect_to event_path(@events), notice: 'Event was successfully created'}
        format.json
        format.xml
      end
    else
      render :new
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date, :category_id, :location, :venue, :image, :template_id, :map_url)
    end

  def set_events
    @event = Event.find(params[:id])
  end
end
