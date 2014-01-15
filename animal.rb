# Inheritance
require_relative 'climbing'
require_relative 'talk'

# Define an parent Animal class
class Animal
  def move
    puts "i can move!"
  end
end

# Define a Mammal class that inherits from Animal
class Mammal < Animal
  include Talk
  def eat
    puts "i can eat! yum yum yum"
  end
  def speak
    puts "i can speak"
  end
end

# Define a Monkey class that inherits from Mammal
class Monkey < Mammal
  include Climbing
  def swing
    puts "i can swing!"
  end
  def speak
    puts "HoWwOo WHoWo"
  end
end

# Define a Dog class that inherits from Mammal
class Dog < Mammal
  def speak
    super
    puts "WHOOF"
  end
end

# Instantiate a Monkey and show off what it can do
puts "\nI'm a Monkey and I can:"
timmy = Monkey.new
timmy.move
timmy.eat
timmy.swing
timmy.speak
timmy.climb
timmy.say("Soup brew")

# timmy.climb

# Instantiate a Dog and show off what it can do
puts "\nI'm a Dog and I can:"
sammy = Dog.new
sammy.move
sammy.eat
sammy.speak
