require_relative './spec_helper'

describe Rental do
  context 'When testing the Rental class' do
    date = '02/02/2022'
    person = Person.new(22, 'Maya')
    book = Book.new('title', 'author')
    rental = Rental.new(date, person, book)

    it 'rental should be an instance of Rental' do
      expect(rental).to be_instance_of Rental
    end
  end
end
