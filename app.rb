require './generate_books'
require './generate_people'
require './generate_rentals'

class App
  attr_reader :books_class, :people_class, :rentals_class

  def initialize
    @books_class = GenerateBooks.new
    @people_class = GeneratePeople.new
    @rentals_class = GenerateRentals.new
  end

  def fetch_data
    @books_class.fetch_books
    @people_class.fetch_people
    @rentals_class.fetch_rentals
  end
end
