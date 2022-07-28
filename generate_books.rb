require './book'
require './data_values'
require 'json'

class GenerateBooks
  include DataValues

  def initialize
    @books = DataValues.books
  end

  def fetch_books
    # Get data from the file
    return unless File.exist?('books.json')

    book_data = File.read('books.json')
    return unless book_data.length.positive?

    data = JSON.parse(book_data)
    data.each_with_index do |book, _index|
      @books.push(Book.new(book['title'], book['author']))
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def list_books
    if @books.length.positive?
      @books.each_with_index do |book, index|
        puts "#{index + 1} - Book title: #{book.title}, Book author: #{book.author}"
      end
    else
      puts 'There are no books, Please add a book first'
    end
  end

  def save_books
    # Preserve data in the file
    book_content = []
    @books.each do |book|
      book_content.push({ 'json_class' => self.class.name,
                          'title' => book.title, 'author' => book.author })
    end
    File.write('books.json', JSON.generate(book_content))
  end
end
