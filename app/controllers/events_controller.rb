class EventsController < ApplicationController

    before_action :login_required, except: [:index, :search, :show]
    before_action :edit_member, only: [:edit, :update]

    def new_1
        #会場, 時間帯
        @event = Event.new(
            host_id: current_member.id, 
            held_at: Date.today.next
            )
        @places = Place.all.readonly #ランク制限未実装
        @event.place_booking = PlaceBooking.new(
            start_time: Time.now,
            end_time: Date.today.next
            )
        
    end

    def new_2
        #その他イベント情報設定
        @event = Event.new(eventParams)     

        if placeBookingParams[:place_id].present? then            
            @event.place_booking = PlaceBooking.new(placeBookingParams)
            @event.place_booking.start_time = timeDateConverte(@event.place_booking.start_time, @event.held_at)
            @event.place_booking.end_time = timeDateConverte(@event.place_booking.end_time, @event.held_at)

            if !@event.place_booking.valid? then
                redirect_to :new_1_events
            end
        end
                
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

    def show
        @event = Event.find(params[:id])
    end

    def edit
        @event = Event.find(params[:id])
    end
    
    def update
    end

    #Method
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

    private def placeBookingParams
        params.require(:place_booking).permit(
            :start_time,
            :end_time,
            :place_id        
        )
    end

    private def timeDateConverte(t, d)
        #第1引数tのDateだけをdに揃えて日付ｄ時間tな文字列をつくるメソッド
        return "#{d.year}-#{d.month}-#{d.day} #{t.hour}:#{t.min}:#{t.sec}"
    end

    #例外処理
    class EventMember < StandardError; end
    rescue_from EventMember, with: :rescue_forbidden
    private def edit_member
        if Event.find(params[:id]).member == current_member then
            return current_member
        else
            raise EventMember
        end
    end
end
