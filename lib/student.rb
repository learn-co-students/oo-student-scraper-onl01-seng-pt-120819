class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash) #Mass Assignment and Metaprogramming lesson
    student_hash.each do |key, value|
      self.send(("#{key}="), value)
        @@all << self
    end
  end
  
  def self.create_from_collection(students_array)
    students_array.each  do |student_hash|
     Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash) #additional attributes of an individual student / student_hash
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
    end
  end

  def self.all
    @@all
  end
end

