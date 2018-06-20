class ProductsNotifierMailer < ApplicationMailer
  default from: 'warsztaty@infakt.pl'
  layout 'mailer'

  def take_notify(book,user)
    @book=book
    @user=user
    #puts @book.title
    #puts @user.email
    mail(to: user.email, subject: book.title)
  end

  def discount(product, user)
    @product = product
    @user = user
    
    mail(to: user.email, subject: "Przeceniliśmy produkt!")
  end
end
