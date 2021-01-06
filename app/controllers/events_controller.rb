class EventsController < ApplicationController

    def new_1 
    end

    def new_2 
    end

    def index
        @events = Event.order("held_at")
            .page(params[:page]).per(15)
    end

    def search
        @events = Event.search(params[:sword])
            .page(params[:page]).per(15)
        render "index"
    end


end
