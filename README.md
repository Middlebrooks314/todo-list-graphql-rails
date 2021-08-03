# Todo List Graphql Rails
[![Middlebrooks314](https://circleci.com/gh/Middlebrooks314/todo-list-graphql-rails.svg?style=shield)](https://app.circleci.com/pipelines/github/Middlebrooks314/todo-list-graphql-rails)

## Summary
Capstone project: Todo application API. 

## Technologies
- Rails
- Graphql

## Installation

Make sure you have ruby installed on your machine. 

```bash
$ ruby -v
```

Clone the repository to your local machine and install the dependencies:
```bash
$ git clone https://github.com/Middlebrooks314/todo-list-graphql-rails.git
$ cd todo-list-graphql-rails
$ bundle install
```

This project uses a postgresql database to set up the database run:

``` bash
$ rails db:create
$ rails db:migrate
```

## Usage

To start the local server run: 

``` bash
$ rails s
```
Go to `https://localhost:3000/graphiql` to make queries and mutations on the graphiql tool.

The application is also deployed on Heroku at:
`https://todo-graphql-rails.herokuapp.com/graphql`

## Testing

To run the tests run:
```bash
$ rspec
```
To run the linter run:
```bash
$ rubocop
```

There is a pre-commit hook to run the linter and a pre-push hook to run the tests. To use these run: 

```bash
$ ./scripts/install-hooks.bash
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)