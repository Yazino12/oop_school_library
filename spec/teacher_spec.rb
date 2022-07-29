require_relative './spec_helper'

describe Teacher do
  context 'When testing the Teacher class' do
    specialization = 'Hit Man'
    age = 40
    name = 'Jackson'
    teacher = Teacher.new(specialization, age, name)
    it 'teacher should be an instance of Teacher' do
      expect(teacher).to be_instance_of Teacher
    end
    it 'can_use_services? method should be true' do
      expect(teacher.can_use_services?).to be_truthy
    end
  end
end
