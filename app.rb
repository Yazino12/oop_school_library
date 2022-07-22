require './student'
require './teacher'
require './book'
require './rental'

class App
  def list_books
    if @books.length.zero?
      puts "There are no books, Please add a book first"
    else
      @books.each_with_index do |book, index|
        puts "#{index + 1} - Book title: #{book.title}, Book author: #{book.author}"
      end
    end
  end

  def list_persons
    if @persons.length.zero?
      puts "There are no people, Please add a person first"
    else
      @persons.each_with_index do |person, index|
        if person.is_a?(Teacher)
          puts "[Teacher] #{index + 1} - ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
        else
          puts "[Student] #{index + 1} - ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
        end
      end
    end
  end

  def person_object(id)
    @persons.each do |person|
      return person if person.id == id
    end
    nil
  end

  def list_rentals
    puts 'Select a person by ID: '
    list_persons
    print_message if @persons.length.zero?
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

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    if(name.strip.length > 0 && age.strip.length > 0 && specialization.strip.length > 0)
        Teacher.new(specialization, age, name)
    else
        puts 'Please dont leave any empty spaces'
        create_teacher
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Parent permission [y/n]: '
    permission = gets.chomp
    if(name.strip.length > 0 && age.strip.length > 0 && permission.strip.length > 0)
        case permission
        when 'y'
          Student.new(age, name)
        when 'n'
          Student.new(age, name, parent_permission: false)
        else
          puts 'Please select a correct option'
          create_student
        end
    else
        puts 'Please dont leave any empty spaces'
        create_student
    end
  end

  def create_person
    print "Do you want to create a student (1) or a teacher (2)? [Input the number]: "
    option = gets.chomp.to_i
    case option
    when 1
        @persons.push(create_student)
    when 2
        @persons.push(create_teacher)
    else
      puts 'Please select a correct option'
      create_person
    end
    puts 'Person created successfully!'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book by number '
    list_books
    print_message if @books.length.zero?
    book_index = gets.chomp.to_i
    puts 'Select a person by number: '
    list_persons
    print_message if @persons.length.zero?
    person_index = gets.chomp.to_i
    print 'Enter date: '
    date = gets.chomp
    Rental.new(date, @persons[person_index - 1], @books[book_index - 1])
    puts "Rental created succesfully -
    book: #{@books[book_index - 1].title}, Person: #{@persons[person_index - 1].name}, Date: #{date}"
  end

  def handle_input(option)
    case option
    when 1
      list_books
    when 2
      list_persons
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    when 7
      puts 'Thank you for using this app'
      exit
    else puts 'Please select a valid option'
         print_message
    end
  end

  def print_message
    puts "\nPlease choose an option by entring a number:\n1 - List all books\n2 - List all people
3 - Create a person\n4 - Create a book\n5 - Create a rental\n6 - List all rentals for a given person id\n7 - Exit"
    option = gets.chomp.to_i
    handle_input(option)
    print_message
  end

  def run
    @books = []
    @persons = []
    puts 'Welcome to School Library App!'
    print_message
  end
end