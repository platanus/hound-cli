# Hound CLI

Ruby CLI created to get and build style rules we use in Platanus to play with linters.

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
-rw-r--r--  1 user  staff   9.8K Jun 19 00:51 .eslintrc.json
-rw-r--r--  1 user  staff    35K Jun 19 00:51 .rubocop.yml
-rw-r--r--  1 user  staff   3.7K Jun 19 00:51 .scss-lint.yml
```

**If you have a `.hound.yml` file**, you will get one file for each **enabled** language in `.hound.yml`.

Example:

If you have the `.hound.yml` file:

```yaml
---
ruby:
  :enabled: true
scss:
  :enabled: false
eslint:
  :enabled: false
```

You will get:

```
-rw-r--r--  1 user  staff    27B Jun 19 00:58 .hound.yml
-rw-r--r--  1 user  staff    35K Jun 19 00:58 .rubocop.yml
```

As you can see, `.rubocop.yml` file was only created because `ruby` was enabled.

In addition, general rules, will be mixed with the rules in a file pointed by the `config_file` key in `.hound.yml`.
So, If you want to merge your custom rules with the default rules, you will need to add the `config_file` key and create the file with overwritten rules (`.ruby-style.yml` in the following example).

Example:

```yaml
---
ruby:
  :enabled: true
  :config_file: ".ruby-style.yml"
scss:
  :enabled: false
eslint:
  :enabled: false
```

You will get:

```
-rw-r--r--  1 user  staff   111B Jun 19 01:01 .hound.yml
-rw-r--r--  1 user  staff    35K Jun 19 00:58 .rubocop.yml
-rw-r--r--  1 user  staff     6B Jun 19 01:02 .ruby-style.yml
```

#### Configure

```
$ hound configure
```

After running this command in your project's root path, you will get:

- A `.hound.yml` file with configuration for each language configured in this gem.

- One file to override default rules for each language. You can edit those files if you want to override default style rules.

Example:

```yaml
---
ruby:
  :enabled: true
  :config_file: ".ruby-style.yml"
scss:
  :enabled: true
  :config_file: ".scss-style.yml"
eslint:
  :enabled: true
  :config_file: ".eslint-style.json"
```

You will get:

```
-rw-r--r--  1 user  staff   123B Jun 19 01:08 .eslint-style.json
-rw-r--r--  1 user  staff   180B Jun 19 01:08 .hound.yml
-rw-r--r--  1 user  staff   120B Jun 19 01:08 .ruby-style.yml
-rw-r--r--  1 user  staff   120B Jun 19 01:08 .scss-style.yml
```

Also, you can pass the `--lang` option to `configure` to pick linters you want to use.

Example:

```
$ hound configure --lang=ruby,scss
```

```yaml
---
ruby:
  :enabled: true
  :config_file: ".ruby-style.yml"
scss:
  :enabled: true
  :config_file: ".scss-style.yml"
```

You will get:

```
-rw-r--r--  1 user  staff   180B Jun 19 01:08 .hound.yml
-rw-r--r--  1 user  staff   120B Jun 19 01:08 .ruby-style.yml
-rw-r--r--  1 user  staff   120B Jun 19 01:08 .scss-style.yml
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
