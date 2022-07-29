require_relative './decorator'

class CapitalizeDecorator < Decorator
  def correct_name
    @component.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @component.correct_name[0..9]
  end
end
