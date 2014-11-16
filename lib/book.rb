class Book < Struct.new(:asset_id, :title)
  extend Base

  def self.book_key_title_db
    @book_key_title_db ||= connect_db('BKLibrary')
  end

  def self.all
    query = 'select ZASSETID, ZTITLE from ZBKLIBRARYASSET'
    book_key_title_db.execute(query).map { |row| Book.new(*row) }
  end

  def annotations
    Annotation.all_for_book(asset_id)
  end
end
