require_relative './spec_helper'

describe Person do
  context 'When testing the Person class' do
    age = 13
    name = 'Chriss'
    person = Person.new(age, name)

    it 'Person age should equal 13' do
      expect(person.age).to be >= 13
    end

    it 'Person name should be Chriss' do
      expect(person.name).to eql 'Chriss'
    end

    it 'Person can_use_services? should be true' do
      expect(person.can_use_services?).to be true
    end

    it 'Person rentals should be empty' do
      expect(person.rentals.length).to be 0
    end
  end
end
