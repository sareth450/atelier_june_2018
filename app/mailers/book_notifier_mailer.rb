class BookNotifierMailer < ApplicationMailer
  def book_return_remind(book)
    @book = book
    @reservation = book.reservations.find_by(status: 'TAKEN')
    @borrower = @reservation.user
    mail(to: @borrower.email, subject: "Uplywa termin oddania ksiazki #{@book.title}")
  end

  def book_reserved_return(book)
    @book = book
    @reservation = book.reservations.find_by(status: 'RESERVED')
    @awaiting = @reservation.user
    mail(to: @awaiting.email, subject: "Zbliza sie termin ponownej dostepnosci ksiazki #{@book.title}")
  end
end
