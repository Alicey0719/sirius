class Admin::PlacesController < Admin::Base

    before_action :admin_login_required

    def index
        @places = Place.all
            .order("id")
            .page(params[:page]).per(50)
    end

    def show
        @place = Place.find(params[:id])
    end

    def destroy
        p = Place.find(params[:id])
        p.destroy
        redirect_to :admin_places, notice: "会場を解除しました"
    end

    def edit
        @place = Place.find(params[:id])
    end

    def update
        @place = Place.find(params[:id])
        @place.assign_attributes(placeParams)
        if @place.save
            redirect_to admin_place_path(@place), notice: "会場情報を更新しました"
        else
            render "edit"
        end
    end

    def new
        @place = Place.new
    end

    def create
        @place = Place.new(placeParams)
        if @place.save then
            redirect_to admin_place_path(@place), notice: "会場を登録しました"
        else
            render "new"
        end
    end

    #params
    private def placeParams
        params.require(:place).permit(
            :name,
            :address,
            :capacity,
            :rank
        )
    end

end