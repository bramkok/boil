# boil

> Simple and fast scaffolding

## Usage:

```
$ boil [--option <argument>]
```

### Options

##### `-h`, `--help`

Display help information.

##### `-b`, `--boilerplate` **[REQUIRED]**

Choose a boilerplate hosted on GitHub. Input format:

`--boilerplate username/repository`

* Bash [`bramkok/boilerplate-bash`](https://github.com/bramkok/boilerplate-bash)
* ES2015 [`bramkok/boilerplate-es6`](https://github.com/bramkok/boilerplate-es6)

##### `-n`, `--name` **[REQUIRED]**

Pick a name for the project.

##### `-d`, `--description`

Description of the project.

##### `-a`, `--author`

Name of the project's author.

##### `-u`, `--username`

GitHub username.

##### `-p`, `--path`

Target path of the project.

### Testing

Use [Bats](https://github.com/sstephenson/bats) (Bash Automated Testing System)
for testing. The Bats testing file for `boil` can be found in the '/test'
directory.

#### Usage

```
$ bats test/boil.bats
```

## License

MIT © [Bram Kok](https://bramkok.com)
