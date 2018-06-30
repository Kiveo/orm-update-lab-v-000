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

  def save #create a row, assign its id, and prevent duplicates
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create(:name, :grade)
    student = Student.new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row_array)
    student = Student.new(row[0], row[1], row[2])    #id, name, grade
    student.save
    student    
  end 
  
end
