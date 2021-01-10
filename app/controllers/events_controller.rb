class EventsController < ApplicationController

    before_action :login_required, except: [:index, :search, :show]
    before_action :edit_member, only: [:edit, :update]

    #StdAction
    def new_1
        #会場, 時間帯
        @event = Event.new(held_at: Date.today.next)
        @event.member = current_member  

        @places = Place.all.readonly #ランク制限未実装

        @event.place_booking = PlaceBooking.new(
            start_time: Time.now,
            end_time: Date.today.next
            )
        
    end

    def new_2
        #その他イベント情報設定
        @event = Event.new(eventParams)
        @event.member = current_member
        @event.tags = Tag.all    
        

        if placeBookingParams[:place_id].present? then            
            @event.place_booking = PlaceBooking.new(placeBookingParams)
            @event.place_booking.start_time = timeDateConverte(@event.place_booking.start_time, @event.held_at)
            @event.place_booking.end_time = timeDateConverte(@event.place_booking.end_time, @event.held_at)

            if !@event.place_booking.valid?(:check) then
                cookies.signed[:pb] = {value:@event.place_booking.errors.full_messages, expires:30.seconds.from_now}
                redirect_to :new_1_events
            end
        end
                
    end

    def index
        @events = Event.order("held_at")
            .page(params[:page]).per(15)
    end

    def search
        @tags = Tag.find(tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i})
        if tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i}.present? then
            @events = Event.search(params[:sword])
                .where(tags:tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i})
                .page(params[:page]).per(15)
        else
            @events = Event.search(params[:sword])
                .page(params[:page]).per(15)
        end
        render "index"
    end

    def show
        @event = Event.find(params[:id])
    end

    def edit
        @event = Event.find(params[:id])
    end

    def create
        @event = Event.new(eventParams)
        @event.member = current_member
        
        if placeBookingParams[:place_id].present? then            
            @event.place_booking = PlaceBooking.new(placeBookingParams)
            if !@event.place_booking.valid? then
                redirect_to :new_1_events and return
            end
        end      
        
        p @event.tags

        if @event.save then            
            @event.tags = Tag.find(tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i})
            if @event.save then
                redirect_to @event, notice: "イベントを作成しました" and return
            else
                render "new_2" and return
            end
        else
            render "new_2" and return
        end        
    end
    
    def update
        @event = Event.find(params[:id])
        @event.assign_attributes(eventParams)
        @event.tags = Tag.find(tagParams[:tag_ids].compact.delete_if(&:empty?).map{|n| n.to_i})
        if @event.save
            redirect_to @event, notice: "イベントを更新しました"
        else
            render "edit"
        end
    end

    def destroy
        e = Event.find(params[:id])
        e.destroy
        redirect_to :event_his_my, notice: "イベントが削除されました"
    end

    #BuyAction
    def buy
        @event = Event.find(params[:id])
    end

    def buy_create
        stat = false
        @event = Event.find(params[:id].to_i)
        ActiveRecord::Base.transaction do
            1.upto(ticketParams[:num].to_i) do |n|
                @t = Ticket.new(
                    member_id: current_member.id,
                    event_id: @event.id
                )
                if @t.save then
                    stat = true
                else
                    stat = false
                    raise ActiveRecord::Rollback
                end
            end
        end

        if stat then
            redirect_to result_event_path(@event.id)
        else
            render "buy"
        end
    end

    def result
    end

    #bkm
    def bkm
        event = Event.find(params[:id])
        current_member.bookmarked_events << event
        redirect_back(fallback_location: root_path, notice: "ブックマークに追加しました")
    end

    def unbkm
        event = Event.find(params[:id])
        current_member.bookmarked_events.destroy(event)
        redirect_back(fallback_location: root_path, notice: "ブックマークを解除しました")
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

    private def placeBookingParams
        params.require(:place_booking).permit(
            :start_time,
            :end_time,
            :place_id        
        )
    end

    private def tagParams
        params.require(:tagData).permit(tag_ids: [])
    end

    private def ticketParams
        params.require(:ticket).permit(:num)
    end

    #Method
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
