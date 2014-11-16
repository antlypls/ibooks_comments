require 'sqlite3'

module Base
  def find_db(dir)
    Dir.glob(File.expand_path(File.join(dir, '*.sqlite'))).first
  end

  def connect_db(sub_dir)
    full_path = File.join(Base.data_path, sub_dir)
    SQLite3::Database.open(find_db(full_path), readonly: true)
  end

  class << self
    attr_accessor :data_path
  end
end
