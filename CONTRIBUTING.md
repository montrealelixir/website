# How to contribute to the community website

First off, thank you for taking the time to contribute! The Elixir Community Website provides you
an opportunity to learn and contribute to an Elixir project in production.

The following is a set of guidelines for contributing to the Elixir community Website.
These are mostly guidelines, not rules. Use your best judgment, and feel free to propose
changes to this document in a pull request.

## Table Of Contents

1. [What should I know before I get started?](#what-should-i-know-before-i-get-started)
2. [How Can I Contribute?](#how-can-i-contribute)
3. [Style Guides](#style-guides)
  * [Git Commit Messages](#git-commit-messages)
  * [Elixir Style Guide](#elixir-style-guide)  
  * [JavaScript Style Guide](#javascript-style-guide)
  * [Test Style Guide](#test-style-guide)
  * [Documentation Style Guide](#documentation-style-guide)
4. [How to configure external apps for development?](https://github.com/montrealelixir/website/blob/master/README.md#configure-external-api-access-keys)
5. [Credits](#credits)

## What should I know before I get started?

You will need a basic understanding of the following technologies:

  * [Elixir](https://elixir-lang.org/), a dynamic, functional language designed for building
    scalable and maintainable applications.
  * [Phoenix](http://www.phoenixframework.org/), a productive web framework that does not compromise
    speed and maintainability.
  * [Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript), if you wish to
    contribute a feature using web sockets.

Understand the purpose and direction of the website:

  * Review the [README.md](README.md) which describes the purpose of the website
  * Review the [static mockup](http://www.montrealelixir.ca/mockup) that helps visualize the website features that we consider a minimum viable product (MVP)

## How Can I Contribute?

* Provide suggestions for the website in the form of [issues](https://github.com/montrealelixir/website/issues)
* Improve the on-boarding experience via the [README.md](README.md) and [CONTRIBUTING.md](CONTRIBUTING.md) files
* Upgrade out-dated packages
* Add a new feature based on the [static mockup](http://www.montrealelixir.ca/mockup) or
  a feature recorded in [issues](https://github.com/montrealelixir/website/issues)

When creating a PR for your contribution:

* Fill in the [required template](PULL_REQUEST_TEMPLATE.md)
* Do not include issue numbers in the PR title
* Include screenshots and animated GIFs in your pull request whenever possible.
* Follow the [Elixir](#elixir-style-guide) and [JavaScript](#javascript-style-guide) style guides.
* Include thoughtfully-worded, well-structured test docstrings. See the [Test Style Guide](#test-style-guide) below.
* Document new code based on the [Documentation Style Guide](#documentation-style-guide)
* End all files with a newline
* Make sure tabs are converted to spaces
* Ensure your code will pass on CI by running `mix project.check`. See [`mix.exs`](mix.exs) to see
  what tasks are executed for this `mix` alias.

## Style Guides

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line
* When only changing documentation, include `[ci skip]` in the commit description

### Elixir Style Guide

The style is enforced by the static code analysis tool, [Credo](https://github.com/rrrene/credo).
Anything outside of what Credo provides is outlined in [Elixir Community Style Guide](https://github.com/christopheradams/elixir_style_guide).
If there is a conflict between these two resources, Credo takes precedence.

### Javascript Style Guide

All JavaScript must adhere to [JavaScript Standard Style](http://standardjs.com/).

### Test Style Guide

* Include thoughtfully-worded, well-structured [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)
  tests.
* Treat `describe` as the unit of work.
* Treat `test` as a statement about the state under test and expected behavior.
* Variable names should express the expected input and state; e.g. `invalid_customer_params`,
`empty_list`
* Separate the three parts of the test (arrange, act, assert) with a single line, if any of the three parts are two
  lines or more. Otherwise keep all three parts/lines together (no line separation).

```elixir
describe "sum" do
  test "negative number as 1st param throws exception" do
    # arrange, act, assert
  end

  test "negative number as 2nd param throws exception" do
    # arrange, act, assert    
  end

  test "simple values calculate" do
    # arrange, act, assert    
  end
end
```

Some of this style guide is influenced by Roy Osherove's [Naming standards for unit tests](http://osherove.com/blog/2005/4/3/naming-standards-for-unit-tests.html).

### Documentation Style Guide

All modules require `@moduledoc` documentation, except those modules that have clear suffixes,
e.g. `Controller`, `View`. All __public__ functions should be documented using `@doc`, except those
that are repeated throughout the codebase, e.g. `index` function in `Controller`s and `render`
functions in `View`s.

[Typespecs](https://hexdocs.pm/elixir/typespecs.html) are not mandatory, but highly
desirable. The rules outlined above for public functions apply to Typespecs as well.

## Credits

This document uses content from [Atom CONTRIBUTING.md](https://github.com/atom/atom/blob/master/CONTRIBUTING.md).
