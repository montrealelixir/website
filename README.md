# WELCOME TO THE MONTREAL ELIXIR COMMUNITY WEBSITE

[![Build Status](https://travis-ci.org/montrealelixir/website.svg?branch=master)](https://travis-ci.org/montrealelixir/website)

You've found the source code for our community website: http://www.montrealelixir.ca. You lucky devil! The website is a single-page application aggregating several of our online properties:

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
    open source project (do it!)

## Getting started

These instructions will get you a copy of the application up and running on your local machine for
development and testing purposes.

See Hosting and Deployment for notes on how to deploy the application on a live system.

## Development Setup

You have two options for your development setup:

  1. Docker-based: Setup in a Docker container
  2. Bare-metal: Setup directly on the OS (to be documented)

### Docker-based Development Setup

Prerequisites:

  * [Docker](https://www.docker.com)
  * [docker-Sync](http://docker-sync.io)

Steps:

    git clone https://github.com/montrealelixir/website
    cd website
    make app.config
    # Configure the access keys, see: "External API Access Keys" below
    make

To run the tests:

    make app.test

To view the application with your browser visit:

    make app.console
    http://localhost:4000

Other helpful commands:

    # Execute any command against the application container, change CMD
    make app.do CMD='mix test'
    # Start the docker container
    make docker.start
    # Stop the docker container
    make docker.stop
    # To stop and remove all volumes (including sync volume)
    make docker.clean

### External API Access Keys

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

    make app.console

The [landing page](http://localhost:4000/) should contain the latest tweets from the
configured account. If you tweet something new and it should appear on the web page.

#### YouTube

1. Go to the [Credentials page](https://console.developers.google.com/apis/credentials?project=_).
2. Hit "Create" and Proceed with creating new project.
3. Hit "Create credentials" > API key.
4. Put the generated key in your `env` file.
5. From project's dashboard hit "Enable APIs and Services", search for YouTube Data API and enable it.
6. Start the server locally:

    make app.console

The [landing page](http://localhost:4000/) should contain the 3 latest videos from the
[ElixirMontreal channel](https://youtube.com/channel/UCftyx5k7K_0a3wIGRtE2YQw).

## Deployment

### Staging

`https://montreal-elixir-staging.herokuapp.com` is setup to be automatically deployed when a PR
is merged into `master` and the CI passes, see Heroku's [Pipelines](https://blog.heroku.com/heroku_flow_pipelines_review_apps_and_github_sync#introducing-pipelines) documentation.

`montreal-elixir-staging` can be manually deployed:

    make -f env/staging/Makefile deploy

### Production

`http://www.montrealelixir.ca` (`montreal-elixir-production`) can only be manually deployed (i.e
the "Promote to Production" in the Heroku Pipeline cannot be used for container stacks):

    make -f env/prod/Makefile deploy

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
