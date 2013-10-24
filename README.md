# Grouping Exercises

A solution to the [grouping problem][1].

## Running the Solution

- Make sure you have [Ruby][2] and [Bundler][3] installed

- Clone this repo and `cd` into it.

```bash
$ git clone git@github.com:nilenso/grouping-exercise.git
$ cd grouping-exercise
```

- Fetch all the dependencies

```bash
$ bundle install
```

- Run the program

```bash
$ bin/grouping_exercise -m same_email -f examples/input1.csv
```

- Check `output.csv` to see the results

```bash
$ cat output.csv
```

## Running the Tests

- Navigate to the project root

```bash
$ cd /path/to/project
```

- Run the tests using RSpec

```bash
$ rspec
```

- View the coverage report

```bash
$ open coverage/index.html
```

[1]: https://github.com/jhubert/hiring-exercises/tree/master/grouping
[2]: https://github.com/sstephenson/rbenv#basic-github-checkout
[3]: http://bundler.io/
