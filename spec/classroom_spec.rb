require_relative './spec_helper'

describe Classroom do
  context 'When testing the Classroom class' do
    label = 'A'
    classroom = Classroom.new(label)

    it 'Classroom label should equal to A' do
      expect(classroom.label).to eq label
    end
  end
end
