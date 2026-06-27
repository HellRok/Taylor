# Contributing

## Standard Change Process

1. [Raise an issue](https://github.com/HellRok/Taylor/issues/new) with your
   proposed change, this helps make sure the work you're wanting to do is going
   to be accepted or hasn't already been done
2. Once you've gotten approval, fork the repository, and create a branch
3. Get setup [for local development](/documentation/local_development.md)
4. Make your changes
  4.1. Implement the change
  4.2. Write tests
  4.3. Update the documentation
  4.4. Add a changelog entry
  4.5. Run `dx/exec bundle exec rake ci` to make sure everything is working
  4.6. Commit your changes
  4.7. Push your branch to your fork
5. Create a pull request using [the template](/.github/pull_request_template.md)
6. Respond to any comments and work with me to get your pull request merged
