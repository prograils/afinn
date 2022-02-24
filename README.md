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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/prograils/afinn.
