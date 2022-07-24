require './app'

class Main
  attr_reader :app

  def initialize
    @app = App.new
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def handle_input(option)
    case option
    when 1
      app.list_books
    when 2
      app.list_persons
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.list_rentals
    when 7
      puts 'Thank you for using this app'
      exit
    else puts 'Please select a valid option'
         print_message
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def print_message
    puts "\nPlease choose an option by entring a number:\n1 - List all books\n2 - List all people
3 - Create a person\n4 - Create a book\n5 - Create a rental\n6 - List all rentals for a given person id\n7 - Exit"
    option = gets.chomp.to_i
    handle_input(option)
    print_message
  end

  def main
    app.run
    print_message
  end
end

main = Main.new
main.main