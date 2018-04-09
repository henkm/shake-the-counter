# ShakeTheCounter
[![Gem Version](https://badge.fury.io/rb/shake_the_counter.svg)](https://badge.fury.io/rb/shake_the_counter)
[![Dependency Status](https://gemnasium.com/henkm/shake-the-counter.svg)](https://gemnasium.com/henkm/shake-the-counter)
[![Code Climate](https://codeclimate.com/github/henkm/shake-the-counter/badges/gpa.svg)](https://codeclimate.com/github/henkm/shake-the-counter)


This gem works as a simple Ruby wrapper for the Shake The Counter API. At this point, only a limited number of options is implemented. To be more precise: only enough functionality is implemented to:
- Authenticate
- Get events and details from a `Client`
- Make a reservation which is already marked as paid
- Receive barcodes in return
- Cancel a reservation

Instead of working with JSON, you work with Ruby Classes and intuitive methods.

**This gem communicates with the STC.Tickets TicketAPI Version 1.0** 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shake_the_counter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shake_the_counter

## Original documentation
This gem is based on V1 of the API according to the documentation found here: [https://ticketstest.ticketcounter.nl/swagger/ui/index](https://ticketstest.ticketcounter.nl/swagger/ui/index).

This gem tries to be intuitive and Object Oriented. The naming conventions between the original API and this Ruby implementation are identical. So we have these classes:

`Client` > `Event` > `Performance` > `Section` > `PriceType`

Please note that only parts of the original API are 'native' implemented. For example: `@client.events.first` will return a `<ShakeTheCounter::Event>` object with native methods like `name` and `key`, but some fields are left out. You can access all the fields by requesting the `raw_data` attribte, which has the entire original API response stored as JSON.

## Implemented functions
- [x] Configuration via simple config
- [x] Authentication
- [x] Work with a `Client` that is automatically authenticated
- [x] Get subsequent `events > performances > sections > price_types`
- [x] Make a reservation with minimal options
- [ ] Use coupons / discount codes
- [ ] Make reservations with extra options
- [ ] Events that require date or seat selecting
- [ ] Handle capacity (at this point, we assume that each ticket is always available with no limitation.
- [x] Cancel a reservation
- [ ] Functions from the Subscriptions API
- [ ] Functions from the Statistics API
- [ ] Functions from the Reseller API

## Configuration

First, obtain an API key from Shake The Counter. Set it up like this:

To use this gem in a Rails project:
```ruby
# config/development.rb
config.shake_the_counter.environment	= "test"
config.shake_the_counter.refresh_token	= "MY-REFRESH-TOKEN"
config.shake_the_counter.client_id		= "123-my-client-id-xyz"
config.shake_the_counter.language_code	= "nl-NL"
config.shake_the_counter.client_secret	= "client-secret-goes-here"
```


## Full example 
The example below follows the 'Normal flow to order tickets' as described in the `Getting started with the tickets Api` section of the API Documentation.

```ruby
# setup a client
@client = ShakeTheCounter::Client.new # when called without arguments, credentials will come from configuration 

# get a list if events for client
@events = @client.events
# => [<ShakeTheCounter::Event @name="Event 1" @key="xxx">, <ShakeTheCounter::Event @name="Event 2" @key="yyy">]

# get a list of performances
@performances = @events.first.performances

# get a list of sections
@sections = @perfomances.first.sections

# The above logic can also be a one-liner:
# @sections = @client.events.first.performances.first.sections

# get the prices for a givens section
@section = @sections.first
@price_types = @section.price_types
@price_type.first # => <ShakeTheCounter::PriceType @key="xxx" @name="Ticket" @price=6.0 [...]>

# make a reservation
price_type_list = [{
  PriceKey: @price_types.first.price_key,
  NrOfSeats: 2
}]
@reservation = @section.make_reservation(price_type_list: price_type_list, first_name: 'Joe', last_name: 'Sixpack', email: 'jack@example.com')
# => <ShakeTheCounter::Reservation>

# send a message that we started payment
@client.start_payment(@reservation.key)
# => true

# confirm the reservation
@client.confirm_reservation(reservation_key: @reservation.key, payment_method: 'API Test', amount_paid: 12.0)
# => [<ShakeTheCounter::Ticket @ticket_code="12345566">, <ShakeTheCounter::Ticket @ticket_code="12345567">]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/henkm/shake-the-counter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

This gem is made with love by the smart people at [Eskes Media B.V.](https://www.eskesmedia.nl) and [DagjeWeg.NL Tickets](https://www.dagjewegtickets.nl)
Shake The Counter is not involved with this project and has no affiliation with Eskes Media B.V.