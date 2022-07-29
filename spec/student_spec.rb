require_relative './spec_helper'

describe Student do
  context 'When testing the Student class' do
    age = 40
    name = 'Jackson'
    student = Student.new(age, name)
    it 'student should be an instance of Student' do
      expect(student).to be_instance_of Student
    end
    it 'play_hooky method should print "¯\(ツ)/¯"' do
      expect(student.play_hooky).to eq "¯\(ツ)/¯"
    end
  end
end
