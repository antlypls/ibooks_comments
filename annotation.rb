class Annotation < Struct.new(:note, :selected_text)
  extend Base

  def selected_text?
    !selected_text.nil?
  end

  def note?
    !note.nil?
  end

  def self.book_notes_db
    @book_key_title_db ||= connect_db('AEAnnotation')
  end

  def self.all_for_book(asset_id)
    query = 'select ZANNOTATIONNOTE, ZANNOTATIONSELECTEDTEXT, ZANNOTATIONASSETID, ZPLLOCATIONRANGESTART, ZANNOTATIONTYPE, ZANNOTATIONDELETED from ZAEANNOTATION where ZANNOTATIONTYPE=2 and ZANNOTATIONDELETED = 0 and ZANNOTATIONASSETID = ? order by ZPLLOCATIONRANGESTART'
    res = book_notes_db.execute(query, asset_id)
    res.map { |row| Annotation.new(*row[0, 2]) }
  end
end
