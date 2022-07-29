require './spec_helper'

describe Book do
  context 'When testing the Book class' do
    title = 'The Zilla'
    author = 'Cload'
    book = Book.new(title, author)

    it 'Book title should equal to The Zilla' do
      expect(book.title).to eq title
    end

    it 'Book author should equal to Cload' do
      expect(book.author).to eq author
    end
  end
end
