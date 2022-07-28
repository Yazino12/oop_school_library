require './student'
require './teacher'
require './data_values'

class GeneratePeople
  include DataValues

  def initialize
    @persons = DataValues.persons
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def fetch_people
    # Get data from the file
    return unless File.exist?('people.json')

    people_data = File.read('people.json')
    return unless people_data.length.positive?

    data = JSON.parse(people_data)
    data.each_with_index do |person, _index|
      case person['json_class']
      when 'Student'
        case person['parent_permission']
        when true
          @persons.push(Student.new(person['age'], person['name']))
        when false
          @persons.push(Student.new(person['age'], person['name'], person['parent_permission']))
        end
      when 'Teacher'
        @persons.push(Teacher.new(person['specialization'], person['age'], person['name']))
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

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

  def save_people
    # Preserve data in the file
    people_content = []
    @persons.each do |person|
      case person
      when Teacher
        opt1 = { 'json_class' => 'Teacher', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                 'specialization' => person.specialization }
        people_content.push(opt1)
      when Student
        opt2 = { 'json_class' => 'Student', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                 'parent_permission' => person.parent_permission }
        people_content.push(opt2)
      end
    end
    File.write('people.json', JSON.generate(people_content))
  end
end
