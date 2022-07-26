require './generate_books'
require './generate_people'

class App
  attr_reader :books_class, :people_class

  def initialize
    @books_class = GenerateBooks.new
    @people_class = GeneratePeople.new
  end
end
