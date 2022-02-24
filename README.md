# afinn

Sentiment analysis in Ruby.

Dictionaries included:
* 🇬🇧 English Language
* 🇩🇰 Danish Language
* Emoticions

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'afinn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install afinn

## Usage

```ruby
require 'afinn'

afinn = Afinn.new(language = :da, emoticons = true)
afinn.score('Hvis ikke det er det mest afskyelige flueknepperi...')
#=> -8.0

afinn = Afinn.new(language = :en)
afinn.score_to_words("I had a slow puncture that needed attending to and they took care of it very well. Friendly and efficient staff and a clean and tidy work area. Happy to recommend them and will use them in the future.")
#=> "Positive"
```
## Dictionaries
The dictionaries used in this repository are from a project by Finn Årup Nielsen:
https://github.com/fnielsen/afinn/tree/master/afinn/data

For more information visit:
http://corpustext.com/reference/sentiment_afinn.html

Paper with supplement: http://www2.imm.dtu.dk/pubdb/views/edoc_download.php/6006/pdf/imm6006.pdf

## See also
* https://github.com/fnielsen/afinn - Sentiment analysis in Python with AFINN word list
* https://github.com/darenr/afinn - Sentiment analysis in Javascript with AFINN word list


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/prograils/afinn.
