require 'test_helper'

class SiriusTest < ActionDispatch::IntegrationTest
  
  # test "the truth" do
  #   assert true
  # end

  test "ticketStockTest" do
    e = Event.create(
      host_id: 2,
      name: "テスト用イベント",
      held_at: "2021-12-01",
      capacity: 10,
      price: 1500,
      detail: "--イベント詳細を記述--"
    )

    1.upto(9) do 
      Ticket.create(
        member_id: 1,
        event_id: e.id
      )
    end

    #10枚目買える時
    post "/login", params: { user_name: "Taro", password: "sirius" }
    post "/events/#{e.id}/buy", params: { ticket:{num: 1} }
    assert_response :redirect

    #売り切れで買えない時
    post "/events/#{e.id}/buy", params: { ticket:{num: 1} }
    #assert_response :redirect
    assert_select "li", "Already sold out"
  end

end
