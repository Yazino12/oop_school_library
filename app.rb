require './student'
require './teacher'
require './book'
require './rental'
require 'pry'

class App
  def list_books
    if @books.length.zero?
      puts 'There are no books, Please add a book first'
    else
      @books.each_with_index do |book, index|
        puts "#{index + 1} - Book title: #{book.title}, Book author: #{book.author}"
      end
    end
  end

  def list_persons
    if @persons.length.zero?
      puts 'There are no people, Please add a person first'
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
    if @persons.length.zero?
      puts 'No registered people, Register your self!'
    else
      list_persons
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

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    if name.strip.length.positive? && age.strip.length.positive? && specialization.strip.length.positive?
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
    if name.strip.length.positive? && age.strip.length.positive? && permission.strip.length.positive?
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
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
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
    if @books.length.zero?
      puts 'No books available, Add a book!'
    elsif @persons.length.zero?
      puts "No people registered, Register one!"
    else
      list_books
      puts 'Select a book by number '
      book_index = gets.chomp.to_i
      puts 'Select a person by number: '
      list_persons
      person_index = gets.chomp.to_i
      print 'Enter date: '
      date = gets.chomp
      Rental.new(date, @persons[person_index - 1], @books[book_index - 1])
      puts "Rental created succesfully -
      book: #{@books[book_index - 1].title}, Person: #{@persons[person_index - 1].name}, Date: #{date}"
    end
  end

  def run
    @books = []
    @persons = []
    puts 'Welcome to School Library App!'
  end
end
