# Welcome to the Montreal Elixir Community website

[![Build Status](https://travis-ci.org/montrealelixir/website.svg?branch=master)](https://travis-ci.org/montrealelixir/website)

You've found the source code for our community website: http://www.montrealelixir.ca. The website
is a single-page application aggregating several of our online properties:

  * [Meetup.com](https://www.meetup.com/montrealelixir)
  * [Twitter](https://twitter.com/montrealelixir)
  * [YouTube](https://www.youtube.com/channel/UCftyx5k7K_0a3wIGRtE2YQw)
  * [GitHub](https://github.com/montrealelixir)

The application is built using:

  * [Elixir](https://elixir-lang.org/): a dynamic, functional language designed for building scalable
    and maintainable applications, and
  * [Phoenix Framework](http://www.phoenixframework.org/): a productive web framework that does not
    compromise speed and maintainability.

The website has three main purposes:

  * Promote the Elixir community in Montreal
  * Inform the community members about events and new content
  * Provide an opportunity to learn about Elixir and Phoenix by contributing to an
    open source project    

## Getting started

These instructions will get you a copy of the project up and running on your local machine for
development and testing purposes. See Hosting and Deployment for notes on how to deploy the project
on a live system.

### Prerequisites

We assume you have the following installed:

  * Git
  * Erlang
  * Elixir
  * Node
  * PostgreSQL

### Installing

After you have cloned the repository:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix do ecto.create, ecto.migrate`
* [Configure external API access keys](#configure-external-api-access-keys)
* Install Node.js dependencies with `cd apps/montreal_elixir_web/assets && npm install`
* Start Phoenix endpoint with `cd ../../.. && mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Configure external API access keys

#### Twitter

Montreal Elixir website depends on twitter feed to deliver recent tweets from https://twitter.com/montrealelixir. To
make it work in development, you will need to configure your own twitter account to work with the app.

The following steps assume you already have a working twitter account that has email and mobile phone number confirmed
(Twitter does not generate API keys if these prerequisites are not met).

1. Go to https://apps.twitter.com/.
2. Create New App.
3. From the created app page, go to "Keys and Access Tokens" tab.
4. Create Access Token.
5. (Optionally) change app permissions to Read Only (montrealelixir app only reads tweets from user's timeline).
6. Put generated keys in ```config/dev.secret.exs```.
7. Start the server locally (```mix phx.server```).
8. The [web page](http://localhost:4000/) should contain the latest tweets from the configured account.
9. Tweet something new and it should appear on the web page.
10. That's it! You are all set!

### Running the tests

* Ensure you have the test database created `MIX_ENV=test mix ecto.create`
* Run the tests `mix test`

You can also use the [`mix_test_watch`](https://github.com/lpil/mix-test.watch) package to
automatically run the tests after you save a file: `mix test.watch`

### Learn more about Phoenix Framework

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Contributing

The application is built by our community members like you. If you wish to contribute please review
our CONTRIBUTING.md to help you get started. If you have never contributed to open source before,
[How to Contribute to Open Source](https://opensource.guide/how-to-contribute/) is good resource to
read first. If you need some extra help to get started, please reach our to the [community
organizers and members](https://www.meetup.com/montrealelixir/members/?sort=join_date&desc=0). We
are here to help.

## Hosting and Deployment

The application is deployed to [Heroku](https://www.heroku.com/). If you wish to deploy your own
instance of this application, you can use the [handy deploy button](https://devcenter.heroku.com/articles/heroku-button) below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## License

This project is licensed under the MIT License - see the MIT-LICENSE.md file for details.
