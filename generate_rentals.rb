require './rental'
require './data_values'

class GenerateRentals
  include DataValues
  attr_reader :people_generator, :books_generator

  def initialize
    @persons = DataValues.persons
    @books = DataValues.books
    @people_generator = GeneratePeople.new
    @books_generator = GenerateBooks.new
  end

  def person_object(id)
    @persons.each do |person|
      return person if person.id == id
    end
    nil
  end

  def list_rentals
    if @persons.length.zero?
      puts 'No registered people, Register your self!'
    else
      @people_generator.list_persons
      puts 'Select a person by ID: '
      id = gets.chomp.to_i
      person = person_object(id)
      if person.nil?
        puts 'Wrong input, Please type correct ID'
        return
      end
      rentals = person.rentals
      if rentals.length.zero?
        puts 'No rentals for this person, Please add a rental first'
      else
        rentals.each_with_index do |rent, index|
          puts "#{index + 1} - Date: #{rent.date}, Book: #{rent.book.title} by #{rent.person.name}"
        end
      end
    end
  end

  def create_rental
    if @books.length.zero?
      puts 'No books available, Add a book!'
    elsif @persons.length.zero?
      puts 'No people registered, Register one!'
    else
      @books_generator.list_books
      puts 'Select a book by number '
      book_index = gets.chomp.to_i
      puts 'Select a person by number: '
      @people_generator.list_persons
      person_index = gets.chomp.to_i
      print 'Enter date: '
      date = gets.chomp
      Rental.new(date, @persons[person_index - 1], @books[book_index - 1])
      puts "Rental created succesfully -
        book: #{@books[book_index - 1].title}, Person: #{@persons[person_index - 1].name}, Date: #{date}"
    end
  end
end
