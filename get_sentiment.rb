require 'badfruit'
require 'stanford-core-nlp'
StanfordCoreNLP.load_class('SentimentCoreAnnotations', 'edu.stanford.nlp.sentiment')
StanfordCoreNLP.load_class('RNNCoreAnnotations', 'edu.stanford.nlp.neural.rnn')


bf = BadFruit.new('hk73sdh9btjw5w9t6m2cws9p')
movies = bf.lists.in_theaters
puts "Here is the list of movies:"
movies.each_with_index{|movie, index| puts "#{index + 1}. #{movie.name}"}
puts "\nPlease enter the number of your choice: "
choice = gets.strip!.to_i
movies[choice].reviews.each_with_index{|review, index| puts "#{index + 1} #{review.quote}"}

pipeline =  StanfordCoreNLP.load(:tokenize, :ssplit, :parse, :sentiment)
text = movies[choice].reviews[0].quote
text = StanfordCoreNLP::Annotation.new(text)
puts text
pipeline.annotate(text)
text.get(:sentences).each do |sentence|
#tree = StanfordCoreNLP::RNNCoreAnnotations.new
 #puts sentence.get(:predicted_class).class
 puts sentence.get(:annotated_tree)
  puts sentence.get(:class_name).to_s
end



