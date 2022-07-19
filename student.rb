require './person'

class Student < Person
  def initialize(classroom, age, name = 'Unknown')
    super(age, name)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end

student1 = Student.new(8, 11, 'Carl')
puts student1.can_use_services?
puts student1.play_hooky
puts student1.name
