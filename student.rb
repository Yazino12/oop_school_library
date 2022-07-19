require './person.rb'

class Student < Person
    def initialize(classroom, age, name = 'Unknown', parent_permission: true)
        super(age, name, parent_permission)
        @classroom = calssroom
    end

    def play_hooky
        "¯\(ツ)/¯"
    end

end

student_1 = Student.new(8, 11, "Carl")