require './student'
require './teacher'
require './data_values'

class GeneratePeople
  include DataValues

  def initialize
    @persons = DataValues.persons
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
end
