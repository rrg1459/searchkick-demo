class Book < ApplicationRecord
  searchkick word_start: [:title, :author, :genre]

  def search_data
    {
      title: title,
      author: author,
      genre: genre
    }
  end
end