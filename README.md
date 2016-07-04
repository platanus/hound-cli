# Hound CLI

Ruby CLI created to get and build style rules we use in Platanus to play with linters.
This tool was built to recreate locally, the same behavior we have in [our forked version](https://github.com/platanus/hound) of [Hound](https://github.com/houndci/hound).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hound'
```

And then execute:

```bash
$ bundle install
```

## Usage

### Update command

This command allows you to update style rules for enabled linters.

```
$ hound rules update
```

After running this command you will get one file (with style rules) for each enabled linter in the [.hound.yml](https://raw.githubusercontent.com/platanus/la-guia/master/.hound.yml) file. Those files are understood by linters installed in your system. For example: with `ruby` language, a `.rubocop.yml` file will be created. This `.rubocop.yml`, is read by the [rubocop gem](https://github.com/bbatsov/rubocop) (a ruby linter).

Example:

Having...

```yaml
javascript:
  enabled: false
eslint:
  enabled: true
  config_file: style/config/.eslintrc.json
tslint:
  enabled: false
  config_file: style/config/tslint.json
ruby:
  enabled: true
  config_file: style/config/.rubocop.yml
scss:
  enabled: true
  config_file: style/config/.scss-lint.yml
```

And running...

```bash
$ hound rules update
```

You will get in your `$HOME` path the following files:

```
.eslintrc.json
.rubocop.yml
.scss-lint.yml
```

Also, you can pass a linter's name to update rules for a specific language.

For example:

Running...

```
$ hound rules update ruby
```

You will get an updated `.rubocop.yml` file in your `$HOME` path.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/hound-cli/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Paperclip Attributes is maintained by [platanus](http://platan.us).

## License

Hound CLI is © 2016 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
