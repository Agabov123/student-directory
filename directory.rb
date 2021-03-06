require 'csv'
@students = []
@loadstudents = []
def input_students
    @cohorts = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    puts "Please enter student name: "
    puts "To finish, just hit return twice"
    @students = []
    name = STDIN.gets.chomp.downcase.delete(" ")
    while !name.empty? do
      puts "Enter students country of birth: "
      country = STDIN.gets.strip
      if country.empty?
        country = "n/a"
      end
      puts "Enter student hobby: "
      hobby = STDIN.gets.strip
      if hobby.empty? 
        hobby = "n/a"
      end
      puts "Enter student cohort: "
      cohort = STDIN.gets.strip.downcase
      while true
        if cohort.empty? 
          cohort = "november"
        end
        if @cohorts.include? cohort 
          puts "Please enter student name: "
          break 
        else
          puts "Invalid input for cohort"
          puts "Enter your cohort: "
          cohort = STDIN.gets.strip
        end
      end
      @students << {name: name, country: country, hobby: hobby, cohort: cohort.to_sym}
      name = STDIN.gets.strip
    end
    @students
end
  
def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end
    
def print_students_list
  @students.each do |student|
    puts "#{student[:name]} #{student[:country]} #{student[:hobby]} (#{student[:cohort]} cohort)"
  end
end
    
def print_footer(names)
  people = names.count
  if people == 1
    puts "Overall, we have #{people} gteat student."
  elsif people == 0
    puts "No students yet."
  else
    puts "Overall, we have #{people} gteat students." 
  end
end

def show_students
    print_header
    print_students_list
    print_footer(@students)
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      try_load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" 
end

def save_students
  puts "Please enter the name of the file that you want to write to."
  filename = STDIN.gets.chomp
  file = CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      student_data = [student[:name], student[:country], student[:hobby], student[:cohort]]
      csv << student_data
    end
  end
  puts "Student list was saved to the file."

end

def try_load_students
  puts " Please enter the name of the file taht you want to read from."
  filename = STDIN.gets.chomp
  if filename == ""
    filename = "students.csv"
  end
  return if filename.nil? 
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@loadstudents.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

def load_students(filename)
  f = File.open(filename, "r") do |file|
    file.readlines.each do |line|
    name, country, hobby, cohort = line.chomp.split(',')
      @loadstudents << {name: name, country: country, hobby: hobby, cohort: cohort.to_sym}
    end
    @loadstudents.each do |student|
      puts "#{student[:name]} #{student[:country]} #{student[:hobby]} (#{student[:cohort]} cohort)"
    end
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

interactive_menu