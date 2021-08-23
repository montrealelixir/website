# Deployment

## Staging

`https://montreal-elixir-staging.herokuapp.com` is setup to be automatically deployed when a PR
is merged into `master` and the CI passes, see Heroku's [Pipelines](https://blog.heroku.com/heroku_flow_pipelines_review_apps_and_github_sync#introducing-pipelines) documentation.

`montreal-elixir-staging` can be manually deployed:

    make -f ops/staging/heroku/Makefile deploy

## Production (Gigalixir)

    make -f ops/prod/gigalixir/Makefile deploy

### Setup

Follow the instruction here:

    https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html

To configure the release option for the application:

    gigalixir config:set GIGALIXIR_RELEASE_OPTIONS="montreal_elixir_platform_prod"

## Production (Legacy-Heroku)

`http://www.montrealelixir.ca` (`montreal-elixir-production`) can only be manually deployed (i.e
the "Promote to Production" in the Heroku Pipeline cannot be used for container stacks):

    make -f ops/prod/heroku/Makefile deploy