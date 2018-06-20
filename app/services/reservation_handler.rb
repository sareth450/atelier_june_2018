class ReservationHandler
   def initialize(user, book)
      @user = user
      @book = book
   end

def give_back
    ActiveRecord::Base.transaction do
      book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      next_in_queue.update_attributes(status: 'AVAILABLE') if next_in_queue.present?
    end
end


  def take(user)
    return unless book.can_take?(user)

    if book.available_reservation.present?
      book.available_reservation.update_attributes(status: 'TAKEN')
      products_notifier.take_notify(@book, @user).deliver_now
    else
      book.reservations.create(user: user, status: 'TAKEN')
      products_notifier.take_notify(@book, @user).deliver_now
    end
  end

  def reserve
    return "Book is not available for reservation" unless book.can_reserve?(user)
    book.reservations.create(user: user, status: 'RESERVED')
  end  
 
  def cancel_reservation
    book.reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  def next_in_queue
    book.reservations.where(status: 'RESERVED').order(created_at: :asc).first
  end


   private
   attr_reader :user, :book
    
  def products_notifier
    @products_notifier ||= ::ProductsNotifierMailer
  end
 
end
