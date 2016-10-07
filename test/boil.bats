#!/usr/bin/env bats

setup() {
  export _COMMAND="${BATS_TEST_DIRNAME}/../boil"
  export TMP="${BATS_TEST_DIRNAME}/tmp"
  export BOIL_DEFAULT_PATH="${BATS_TEST_DIRNAME}/tmp"
}

teardown() {
  [ -d "$TMP" ] && rm -rf "$TMP"/bats-*
}

createDuplicateDirs() {
  [ -d "$TMP" ] && mkdir -p "$TMP"/bats-test-x
  [ -d "$TMP" ] && mkdir -p "$TMP"/bats-test-y
}

### General
#####################################################################

@test "\`boil\` without arguments shows usage information." {
  run "${_COMMAND}"
  [ "${lines[2]}" = "Usage:" ]
}

### Help
#####################################################################

@test "\`boil -h\` without arguments exits with status 0." {
  run "${_COMMAND}" -h
  [[ "${status}" -eq 0 ]]
  [ "${lines[2]}" = "Usage:" ]
}

@test "\`boil --help\` without arguments exits with status 0." {
  run "${_COMMAND}" --help
  [[ "${status}" -eq 0 ]]
  [ "${lines[2]}" = "Usage:" ]
}

### Boilerplate
#####################################################################

# Without argument

@test "\`boil -b\` without arguments prints a string." {
  run "${_COMMAND}" -b
  [[ "${output}" == "Option requires a argument: -b" ]]
}

@test "\`boil --boilerplate\` without arguments prints a string." {
  run "${_COMMAND}" --boilerplate
  [[ "${output}" == "Option requires a argument: --boilerplate" ]]
}

# With argument

@test "\`boil -b bramkok/boilerplate-bash\` with value prints a string." {
  run "${_COMMAND}" -b 'bramkok/boilerplate-bash'
  [[ "${output}" == "Option -n, --name is required." ]]
}

@test "\`boil --boilerplate bramkok/boilerplate-bash\` with value prints a string." {
  run "${_COMMAND}" --boilerplate 'bramkok/boilerplate-bash'
  [[ "${output}" == "Option -n, --name is required." ]]
}

# Invalid boilerplate argument with name argument

@test "\`boil -b xyz -n egg-timer\` with incorrect boilerplate prints a string." {
  run "${_COMMAND}" -b 'xyz' -n 'egg-timer'
  [[ "${output}" == "A boilerplate GitHub url must be formatted: 'user/repo'." ]]
}

@test "\`boil --boilerplate xyz --name egg-timer\` with value prints a string." {
  run "${_COMMAND}" -b 'xyz' -n 'egg-timer'
  [[ "${output}" == "A boilerplate GitHub url must be formatted: 'user/repo'." ]]
}

### Name
#####################################################################

# Without argument

@test "\`boil -n\` without arguments prints a string." {
  run "${_COMMAND}" -n
  [[ "${output}" == "Option requires a argument: -n" ]]
}

@test "\`boil --name\` without arguments prints a string." {
  run "${_COMMAND}" --name
  [[ "${output}" == "Option requires a argument: --name" ]]
}

# With argument

@test "\`boil -n egg-timer\` with value prints a string." {
  run "${_COMMAND}" -n 'egg-timer'
  [[ "${output}" == "Option -b, --boilerplate is required." ]]
}

@test "\`boil --name egg-timer\` with value prints a string." {
  run "${_COMMAND}" --name 'egg-timer'
  [[ "${output}" == "Option -b, --boilerplate is required." ]]
}

### Success
#####################################################################

# Successful completion

@test "\`boil -b bramkok/boilerplate-bash -n bats-test-x\` if successful prints a string." {
  run "${_COMMAND}" -b 'bramkok/boilerplate-bash' -n 'bats-test-x' -d 'This is test x' -a 'John X' -u 'johnx'
  [[ "${status}" -eq 0 ]]
}

@test "\`boil -b bramkok/boilerplate-bash -n bats-test-y\` if successful print a string." {
  run "${_COMMAND}" -b 'bramkok/boilerplate-bash' -n 'bats-test-y' -d 'This is test y' -a 'Jill Y' -u 'jilly'
  [[ "${status}" -eq 0 ]]
}

# Name already exists as a directory

@test "\`boil -b bramkok/boilerplate-bash -n bats-test-x\` with duplicate name prints a string." {
  createDuplicateDirs
  run "${_COMMAND}" -b 'bramkok/boilerplate-bash' -n 'bats-test-x'
  [[ "${output}" == "Directory 'bats-test-x' already exists. Enter a different name." ]]
}

@test "\`boil --boilerplate bramkok/boilerplate-bash --name bats-test-y\` with duplicate name prints a string." {
  createDuplicateDirs
  run "${_COMMAND}" -b 'bramkok/boilerplate-bash' -n 'bats-test-y'
  [[ "${output}" == "Directory 'bats-test-y' already exists. Enter a different name." ]]
}
