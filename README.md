# Welcome to the Montreal Elixir Community website

[![Build Status](https://travis-ci.org/montrealelixir/website.svg?branch=master)](https://travis-ci.org/montrealelixir/website)

You've found the source code for our community website: http://www.montrealelixir.ca. The
website is a single-page application aggregating several of our online properties:

  * [Meetup.com](https://www.meetup.com/montrealelixir)
  * [Twitter](https://twitter.com/montrealelixir)
  * [YouTube](https://www.youtube.com/channel/UCftyx5k7K_0a3wIGRtE2YQw)
  * [GitHub](https://github.com/montrealelixir)

The application is built using:

  * [Elixir](https://elixir-lang.org/): a dynamic, functional language designed for
    building scalable and maintainable applications, and
  * [Phoenix Framework](http://www.phoenixframework.org/): a productive web framework
    that does not compromise speed and maintainability.

The website has three main purposes:

  * Promote the Elixir community in Montreal
  * Inform the community members about events and new content
  * Provide an opportunity to learn about Elixir and Phoenix by contributing to an
    open source project

## Getting started

These instructions will get you a copy of the application up and running on your local machine for
development and testing purposes. The instructions below provide a *recommended* path for setting
up the application, however an *alternative* suggestion is offered for those more experienced.

See Hosting and Deployment for notes on how to deploy the application on a live system.

### Prerequisites

We assume you have the following installed:

  * [Git](https://git-scm.com)
  * [Elixir](https://elixir-lang.org/install.html)
  * [NodeJS](https://nodejs.org/en/download/)

#### PostgreSQL

You also need to install [PostgreSQL](https://www.postgresql.org).

_Recommended_

Setup PostgreSQL using a [Docker](https://www.docker.com/) container with [docker-compose](./docker-compose.yml):

```shell
> docker-compose up -d
```

_Alterative_

Install PostgreSQL directly on your development machine using your operating system’s package manager.

### Configuration

The application's configuration follows the [Twelve Factor](https://12factor.net/config)
methodology, which means they are stored in the _environment_.

Copy the [`.env.sample`](./.env.sample) file to the appropriate format for the tool of your choice. You may use `source`, [`direnv`](https://direnv.net), [`nv`](https://github.com/jcouture/nv) or a custom script of your own.

### Run the website

After you have cloned the repository:

1. Install dependencies.

  ```shell
  > mix deps.get
  ```

1. Create and migrate your database.

  ```shell
  > mix do ecto.create, ecto.migrate
  ```

1. To get the Twitter and YouTube content, [configure external API access keys](#configure-external-api-access-keys).

1. Install Node.js dependencies.

  ```shell
  > cd apps/montreal_elixir_web/assets
  > npm install
  ```

1. Start Phoenix endpoint.
  ```shell
  > cd ../../..
  > mix phx.server
  ```

Now you can visit [`http://localhost:4000`](http://localhost:4000) from your favourite browser.

### External API access keys

#### Twitter

Montreal Elixir website depends on twitter feed to deliver recent tweets from
[@montrealelixir](https://twitter.com/montrealelixir). To enable it in development,
you will need to create an app in your own twitter account.

The following steps assume you already have a working twitter account that has email and mobile
phone number confirmed (_Twitter does not generate API keys if these prerequisites are not met_).

1. Go to https://apps.twitter.com/.
2. Create New App.
3. From the created app page, go to "Keys and Access Tokens" tab.
4. Create Access Token.
5. (Optionally) change app permissions to Read Only (montrealelixir app only reads tweets from user's timeline).
6. Put the generated keys in your `env` file.
7. Start the server locally:

```shell
> mix phx.server
```

The [landing page](http://localhost:4000/) should contain the latest tweets from the
configured account. If you tweet something new and it should appear on the web page.

#### YouTube

1. Go to the [Credentials page](https://console.developers.google.com/apis/credentials?project=_).
2. Hit "Create" and Proceed with creating new project.
3. Hit "Create credentials" > API key.
4. Put the generated key in your `env` file.
5. From project's dashboard hit "Enable APIs and Services", search for YouTube Data API and enable it.
6. Start the server locally:

```shell
> mix phx.server
```

The [landing page](http://localhost:4000/) should contain the 3 latest videos from the
[ElixirMontreal channel](https://youtube.com/channel/UCftyx5k7K_0a3wIGRtE2YQw).

### Running the tests

Ensure the test database was created:

```shell
> MIX_ENV=test mix ecto.create
```

* Run the tests

```shell
> mix test
```

You can also use the [`mix_test_watch`](https://github.com/lpil/mix-test.watch) package to
automatically run the tests after you save a file:

```shell
> mix test.watch
```

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
organizers and members](https://www.meetup.com/montrealelixir/members/?sort=join_date&desc=0). We are here to help.

## Hosting and Deployment

The application is deployed to [Heroku](https://www.heroku.com/). If you wish to deploy your own
instance of this application, you can use the [handy deploy button](https://devcenter.heroku.com/articles/heroku-button)
below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## License

This application is licensed under the MIT License - see the MIT-LICENSE.md file for details.
