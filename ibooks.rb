require 'sqlite3'

LIBRARY_DIR = ENV['LIBRARY_DIR']
ANNOTATION_DIR = ENV['ANNOTATION_DIR']

def find_db(dir)
  Dir.glob(File.expand_path(File.join(dir, '*.sqlite'))).first
end

class Book < Struct.new(:asset_id, :title)
  def self.book_key_title_db
    @book_key_title_db ||= SQLite3::Database.open(find_db(LIBRARY_DIR), readonly: true)
  end

  def self.all
    query = 'select ZASSETID, ZTITLE from ZBKLIBRARYASSET'
    book_key_title_db.execute(query).map { |row| Book.new(*row) }
  end

  def annotations
    Annotation.all_for_book(asset_id)
  end
end

class Annotation < Struct.new(:note, :selected_text)
  def selected_text?
    !selected_text.nil?
  end

  def note?
    !note.nil?
  end

  def self.book_notes_db
    @book_notes_db ||= SQLite3::Database.open(find_db(ANNOTATION_DIR), readonly: true)
  end

  def self.all_for_book(asset_id)
    query = 'select ZANNOTATIONNOTE, ZANNOTATIONSELECTEDTEXT, ZANNOTATIONASSETID, ZPLLOCATIONRANGESTART, ZANNOTATIONTYPE, ZANNOTATIONDELETED from ZAEANNOTATION where ZANNOTATIONTYPE=2 and ZANNOTATIONDELETED = 0 and ZANNOTATIONASSETID = ? order by ZPLLOCATIONRANGESTART'
    res = book_notes_db.execute(query, asset_id)
    res.map { |row| Annotation.new(*row[0, 2]) }
  end
end

Book.all.each do |book|
  puts "## #{book.title}\n\n"

  book.annotations.each do |annotation|
    if annotation.selected_text?
      puts "##### Highlight:\n\n"
      puts annotation.selected_text + "\n\n"

      if annotation.note?
        puts "##### Note:\n"
        puts annotation.note + "\n\n\n"
      end
    end
  end
end
