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

  # rubocop:disable Metrics/CyclomaticComplexity
  def fetch_rentals
    # Get data from the file
    return unless File.exist?('rentals.json')

    rental_data = File.read('rentals.json')
    return unless rental_data.length.positive?

    data = JSON.parse(rental_data)
    data.each_with_index do |rental, _index|
      recovered_person = ''
      recovered_book = ''
      @persons.each do |person|
        recovered_person = person if person.id == rental['person_id']
      end
      @books.each do |book|
        recovered_book = book if book.title == rental['book_title']
      end
      Rental.new(rental['date'], recovered_person, recovered_book)
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity
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

  def save_rentals
    # Preserve data in the file
    rentals = []
    rental_content = []
    @persons.each do |person|
      rental_content.push(person) if person.rentals
    end
    return unless rental_content.length.positive?

    rental_content.each do |rental|
      date = ''
      person = ''
      book = ''
      rental.rentals.each do |item|
        break unless item.is_a?(Rental)

        date = item.date
        person = item.person.id
        book = item.book.title
        rentals.push({ 'json_class' => self.class.name,
                       'date' => date, 'person_id' => person, 'book_title' => book })
      end
    end
    File.write('rentals.json', JSON.generate(rentals))
  end
end
