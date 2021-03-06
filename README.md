# ShareCounter

This gem makes it super easy to check how many times a page/URL has been shared on social networks and aggregators.

Services currently supported:

Facebook

Twitter (not yet supported by twitter http://www.i-programmer.info/news/155-social-media/9048-twitter-switches-off-json-api-no-more-tweet-counts.html)

Linkedin

Reddit

Stumbleupon

Pinterest


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'share_counter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install share_counter

## Usage

Take all share count info from each service.

```ruby
share_counter = ShareCounter.all 'www.chorally.com'

{:reddit=>0, :twitter=>47, :facebook=>{:commentsbox_count=>0, :click_count=>0, :total_count=>44, :comment_count=>12, :like_count=>19, :share_count=>13}, :linkedin=>58, :stumbleupon=>nil, :pinterest=>0}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chorally/share_counter.
