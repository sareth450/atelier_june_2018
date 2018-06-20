require 'rails_helper'

describe 'AppRouting' do
  it {
    expect(root: 'books', action: 'index')
  }
end

describe 'ReservationRoute' do
  it {
    expect(get: 'books/12/reserve').to route_to(
      controller: 'reservations',
      action: 'reserve',
      book_id: '12'
      )
}
end

describe 'ReserveRoute2' do
  it{
    expect(get: reserve_book_path(book_id: 12)).to route_to(controller: 'reservations', action: 'reserve', book_id: '12')
}
end

describe 'takeRoute' do
  it {
    expect(get: 'books/10/take').to route_to(
      controller: 'reservations',
      action: 'take',
      book_id: '10'
      )
}
end

describe 'takeRoute2' do
  it{
    expect(get: take_book_path(book_id: 10)).to route_to(controller: 'reservations', action: 'take', book_id: '10')
}
end

describe 'giveRoute' do
  it {
    expect(get: 'books/9/give_back').to route_to(
      controller: 'reservations',
      action: 'give_back',
      book_id: '9'
      )
}
end


describe 'cancelRoute' do
  it {
    expect(get: 'books/1/cancel_reservation').to route_to(
      controller: 'reservations',
      action: 'cancel',
      book_id: '1'
      )
}
end

describe 'userReservation' do
  it {
    expect(get: 'users/5/reservations').to route_to(
      controller: 'reservations',
      action: 'users_reservations',
      user_id: '5'
      )
}
end


describe 'googlin isbn' do
  it {
    expect(get: 'google-isbn').to route_to(
      controller: 'google_books',
      action: 'show'
      )
}
end

