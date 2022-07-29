require './spec_helper'

describe CapitalizeDecorator do
  context 'When testing the CapitalizeDecorator class' do
    person = Person.new(22, 'yaasiinigaa')
    capitalize_decorator = CapitalizeDecorator.new(person)

    it 'correct_name should capitalize the name' do
      expect(capitalize_decorator.correct_name).to eq 'Yaasiinigaa'
    end
  end
end

describe TrimmerDecorator do
  context 'When testing the TrimmerDecorator class' do
    person = Person.new(22, 'yaasiinigaa')
    trimmer_decorator = TrimmerDecorator.new(person)

    it 'correct_name should trim the name length to 9' do
      expect(trimmer_decorator.correct_name).to eq 'yaasiiniga'
    end
  end
end
