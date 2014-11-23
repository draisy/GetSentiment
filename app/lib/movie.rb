require 'badfruit'
class Movie
  attr_accessor :movies, :choice
  BF = BadFruit.new('hk73sdh9btjw5w9t6m2cws9p')

  def initialize
    @movies = BF.lists.in_theaters
  end

  def list_movies
    puts "Here is the list of movies:"
    @movies.each_with_index{|movie, index| puts "#{index + 1}. #{movie.name}"}
  end

  def get_selection
    puts "\nPlease enter the number of your choice: "
    @choice = gets.strip!.to_i
    display_reviews
  end

  def display_reviews
    puts "Here are all the reviews:"
    @movies[@choice].reviews.each_with_index do |review, index|
      puts "#{index + 1} #{review.quote}"
    end
  end

  def get_reviews
    list_movies
    get_selection
    @movies[@choice].reviews.collect{|review| "#{review.quote} "}
  end
end

