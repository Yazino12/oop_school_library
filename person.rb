require './nameable'
require './decorators'
require './rental'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  # rubocop:disable Style/ClassVars
  @@id = 1

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = @@id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @@id += 1
  end
  # rubocop:enable Style/ClassVars

  def correct_name
    @name
  end

  def can_use_services?
    true if of_age? || @parent_permission
  end

  def add_rental(book, date)
    Rental.new(date, self, book)
  end

  private

  def of_age?
    @age >= 18
  end
end
