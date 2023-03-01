# Coveralls

This homebrew tap provides the following package:

`coveralls` - a **universal coverage reporter** for [coveralls.io](https://coveralls.io). See: [github.com/coverallsapp/coverage-reporter](https://github.com/coverallsapp/coverage-reporter)

## Installation

```bash
brew tap coverallsapp/coveralls
brew install coveralls
```

Or

```bash
brew install coverallsapp/coveralls/coveralls
```

## Updating the formula (dev)

1. Update the tag version in formula

2. Fetch SHA265 using this command:

```bash
brew fetch --build-from-source coveralls
```

3. Update the SHA256 in formula.

4. Install locally (check there're no errors)

```bash
brew install --build-from-source coveralls
```

5. Create a separate branch

```bash
git checkout -b coveralls/update-version
```

6. Commit

```bash
git commit -m 'coveralls X.Y.Z'
```

7. Create a PR to `main` branch

8. After bottles are built, add `pr-pull` label to the PR
