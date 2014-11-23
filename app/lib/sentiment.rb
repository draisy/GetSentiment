require 'stanford-core-nlp'
require 'pry'

class Sentiment
  StanfordCoreNLP.load_class('SentimentCoreAnnotations', 'edu.stanford.nlp.sentiment')
  StanfordCoreNLP.load_class('RNNCoreAnnotations', 'edu.stanford.nlp.neural.rnn')
  SENTIMENT_TEXT =  ["Very Negative","Negative", "Neutral", "Positive", "Very Positive"]
  
  attr_accessor :movies, :text, :pipeline, :values

  def initialize
    @movies = Movie.new
  end

  def call
    get_sentiment
  end

  def get_sentiment
    get_annotation
    @values = []
    @text.get(:sentences).each do |sentence|
      tree = StanfordCoreNLP::RNNCoreAnnotations
      #get actual sentiment values
      @values << tree.getPredictedClass(sentence.get:annotated_tree)
      #get sentiment labels
      puts sentence.get(:class_name).to_s
    end
      results
  end

  def get_annotation
    pipeline = StanfordCoreNLP.load(:tokenize, :ssplit, :parse, :sentiment)
    @text = @movies.get_reviews.join
    @text = StanfordCoreNLP::Annotation.new(@text)
    pipeline.annotate(@text)
  end

  def results
    result = @values.inject{ |sum, elm| sum + elm }.to_f / @values.size
    puts "The result is #{result}, so this movie is classified as #{SENTIMENT_TEXT[result.to_i]}."
  end

end
