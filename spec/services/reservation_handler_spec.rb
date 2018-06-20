require "rails_helper"

RSpec.describe ReservationHandler, type: :service do 
  let(:user) { User.new }
  let(:book) { Book.new }
  subject { described_class.new(user,book) }
  
  describe '#reserve' do
    before {
      allow(book).to receive_message_chain(:can_reserve?).with(user).and_return(can_be_reserved)
    }

    context 'without available book' do
      let(:can_be_reserved) { false }
      it {
        expect(subject.reserve()).to eq('Book is not available for reservation')
      }
    end

    context 'with available book' do
      let(:can_be_reserved) { true }

       before {
         allow(book).to receive_message_chain(:reservations, :create).with(no_args).
         with(user: user, status: 'RESERVED').and_return(true)
       }

       it {
         expect(subject.reserve()).to be_truthy
       }
    end
  end
 
  describe '#take' do
    before {
      allow(book).to receive_message_chain(:can_take?).with(user).and_return(can_be)
    }

    context 'Cannot be taken' do
      let(:can_be) { false }
      it {
        expect(subject.take(user)).to eq(nil)
      }
    end
    
    context 'Can be taken' do
      let(:can_be) { true } 
  	
      before{
        allow(book).to receive_message_chain(:available_reservation, :present?).with(no_args).with(no_args).and_return(was_reserved)
        }
     
       context 'was reserved' do
         let(:was_reserved) { true } 
         before {
           allow(book).to receive_message_chain(:available_reservation, :update_attributes).with(status: 'TAKEN').and_return(true)
         }
         it {
           expect(subject.take(user)).to be_truthy
         }	
       end
   
       context 'wasn\'t reserved' do
	  let(:was_reserved) { false }
          before {
            allow(book).to receive_message_chain(:reservations, :create).with(no_args).with(user: user, status: 'TAKEN').and_return(true)
          }
          it {
            expect(subject.take(user)).to be_truthy
          }	
      end
    end
  end
end
