# frozen_string_literal: true

LANGUAGE_TO_FILENAME = {
  da: "da.txt",
  en: "en.txt",
  emoticons: "emoticons.txt",
  emojis: "emojis.txt"
}.freeze

class Afinn
  attr_reader :word_dict

  def initialize(language = :en, emoticons = false)
    read_dictionaries(language, emoticons)
  end

  def score(text)
    text = text.gsub(/[!'",.?]/, "").split(" ")
    scoring = 0
    text.each do |word|
      scoring += @word_dict[word].to_f if @word_dict.include? word
    end
    scoring
  end

  def score_to_words(text)
    scored = score(text)
    if scored.between?(-1.0, 1.0)
      :neutral
    elsif scored > 1.0
      :positive
    else
      :negative
    end
  end

  private

  def read_dictionaries(language, emoticons)
    filename = LANGUAGE_TO_FILENAME[language]
    full_filename = File.join(__dir__, "dictionaries", filename)
    data = read_word_file(full_filename)

    if emoticons
      [:emoticons, :emojis].each do |emoticon|
        filename_emoticons = LANGUAGE_TO_FILENAME[emoticon]
        full_filename_emoticons = File.join(__dir__, "dictionaries", filename_emoticons)
        emo = read_word_file(full_filename_emoticons)
        data = data.merge(emo)
      end
    end
    @word_dict = data
  end

  def read_word_file(file)
    @word_dict = {}
    File.read(file).each_line do |line|
      line = line.strip.split("\t")
      @word_dict.store(line[0], line[1])
    end
    @word_dict
  end
end
