require_relative "../config/environment.rb"
# Remember, you can access your database connection anywhere in this class with DB[:conn]
class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    #sql with here doc, to create the table in db.
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end


end
