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

### Commands

#### Update

This command allows you to update rules for default (or enabled) linters.

```
$ hound update
```

After running this command in your project's root path...

**If you don't have a `.hound.yml` file**, you will get one file (with style rules) for each language configured in this gem. Those files are understood by linters installed in your system. For example: with `ruby` language, a `.rubocop.yml` file will be created. This `.rubocop.yml`, is read by the [rubocop gem](https://github.com/bbatsov/rubocop) (a ruby linter).

Example:

```bash
$ hound update
```

will create...

```
.eslintrc.json
.rubocop.yml
.scss-lint.yml
```

**If you have a `.hound.yml` file**, you will get one file for each **enabled** language in `.hound.yml`.

Example:

If you have the `.hound.yml` file:

```yaml
---
ruby:
  enabled: true
scss:
  enabled: false
eslint:
  enabled: false
```

You will get:

```
.hound.yml
.rubocop.yml
```

As you can see, `.rubocop.yml` file was only created because `ruby` was enabled.

In addition, general rules, will be mixed with the rules in a file pointed by the `config_file` key in `.hound.yml`.
So, If you want to merge your custom rules with the default rules, you will need to add the `config_file` key and create the file with overwritten rules (`.ruby-style.yml` in the following example).

Example:

```yaml
---
ruby:
  enabled: true
  config_file: ".ruby-style.yml"
scss:
  enabled: false
eslint:
  enabled: false
```

You will get:

```
.hound.yml
.rubocop.yml
.ruby-style.yml
```

#### Config

This command allows you to add custom configuration by language.

> Remember: you should avoid creating specific configuration. As far as possible, you should use the default settings.

```bash
$ hound config [language]
```

After running this command in your project's root path, you will get:

- A new or modified `.hound.yml` file with configuration for the given language.

- One file to override default rules for that language. You can edit the file if you want to override default style rules.

Example:

**If you don't have a `.hound.yml` file** and you run:

```bash
$ hound config ruby
```

You will get:

A `.hound.yml` file:

```yaml
---
ruby:
  enabled: true
  config_file: ".ruby-style.yml"
```

And...

```
.hound.yml
.ruby-style.yml
```

**If you have a `.hound.yml` file**:

```yaml
---
ruby:
  enabled: true
  config_file: ".ruby-style.yml"
```

And you run:

```bash
$ hound config scss
```

You will get:

A `.hound.yml` file:

```yaml
---
ruby:
  enabled: true
  config_file: ".ruby-style.yml"
scss:
  enabled: true
  config_file: ".scss-style.yml"
```

And...

```
.hound.yml (updated)
.ruby-style.yml (previously created)
.scss-style.yml (new)
```

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
