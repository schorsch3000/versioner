# versioner
may help you with release management and versioning.

## synopsis
```
Usage: versioner [-h] [-p] [-m] [-M] [-f <file>] [-a <arg>]
  -h  Display this help message
  -p  Bump the version's patch number
  -m  Bump the version's minor number
  -M  Bump the version's major number
      you can't bump more than one places at a time
      without bumping you'll get the current version as output with suffix if used -a
  -f  Specify the version file to use, default is .version
  -a  Append the given argument to the version, default is nothing
  -i  Specify the initial version to use if no version file exists, defaults to 0.0.0
```

