class Admin::EventsController < Admin::Base

    before_action :admin_login_required

    #Action
    def index
        @events = Event.all
            .order("id")
            .page(params[:page]).per(50)
    end

    def show
        @event = Event.find(params[:id])
    end

    def destroy
        e = Event.find(params[:id])
        e.destroy
        redirect_to :admin_events, notice: "イベントを解除しました"
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.assign_attributes(eventParams)
        @event.tags = Tag.find(tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i})
        if @event.save
            redirect_to admin_event_path(@event), notice: "イベントを更新しました"
        else
            render "edit"
        end
    end

    #StrongParams
    private def eventParams
        params.require(:event).permit(
            :host_id,
            :name,
            :held_at,
            :capacity,
            :price,
            :detail
        )
    end

    private def tagParams
        params.require(:tagData).permit(tag_ids: [])
    end

end