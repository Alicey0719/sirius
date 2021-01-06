class EventsController < ApplicationController

    def new_1 
    end

    def new_2 
    end

    def index
        @events = Event.all
    end


end
