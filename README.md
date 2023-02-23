# Coveralls

This homebrew tap provides the following package:

`coveralls` - a **universal coverage reporter** for [coveralls.io](https://coveralls.io). See: [github.com/coverallsapp/coverage-reporter](https://github.com/coverallsapp/coverage-reporter)

## Installation

```
brew tap coverallsapp/coveralls
brew install coveralls
```

Or

```
brew install coverallsapp/coveralls/coveralls
```

## Updating the formula (dev)

1. Update the tag version in formula

2. Fetch SHA265 using this command:

```
brew fetch --build-from-source coveralls
```

3. Update the SHA256 in formula.

4. Install locally (check there're no errors)

```
brew install --build-from-source coveralls
```

