class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_accessor :name, :age
  attr_reader :id

  def can_use_services?
    true if of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end

man = Person.new(17, 'Yasin')
puts man.can_use_services?
