class PlacesController < ApplicationController

    before_action :login_required

    def index
        @places = Place.all
            .order("id")
            .page(params[:page]).per(50)
    end

    def show
        @place = Place.find(params[:id])
    end

end