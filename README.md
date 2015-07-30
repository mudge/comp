# comp [![Build Status](https://travis-ci.org/mudge/comp.svg?branch=master)](https://travis-ci.org/mudge/comp)

A Ruby library to add [function
composition](https://en.wikipedia.org/wiki/Function_composition) to
[`Proc`s](http://ruby-doc.org/core/Proc.html) (including `lambda`s) and
[`Method`s](http://ruby-doc.org/core/Method.html).

**Current version:** 1.0.0  
**Supported Ruby versions:** 1.9.2, 1.9.3, 2.0, 2.1, 2.2

## Installation

```
gem install comp -v '~> 1.0'
```

Or, in your `Gemfile`:

```ruby
gem 'comp', '~> 1.0'
```

## Usage

```ruby
require 'comp'

# Basic usage
add = proc { |x, y| x + y }
double = proc { |x| x * 2 }
double_after_add = double * add

double_after_add.call(1, 2)
#=> 6

# Composing Procs and other callables
class Parser
  def call(json)
    JSON.load(json)
  end
end

extract_name = proc { |attributes| attributes.fetch('name') }
(extract_name * Parser.new).call('{"name": "Alice"}')
#=> "Alice"
```

Requiring `comp` will require two files:

* `comp/proc`: add [`Proc#*`](#proc) if it hasn't already been defined;
* `comp/method`: add [`Method#*`](#method) if it hasn't already been defined.

## API Documentation

### `Proc#*`

```ruby
increment_and_add = proc { |x| x * 2 } * proc { |x| x + 1 }
increment_and_add.call(1)
#=> 4
```

Composes a `Proc` (`f`) with any object that responds to `call` (`g`) returning
a new `Proc` which will call `g` with any given arguments (including blocks)
and then call `f` with the result.

If `f` was created with `lambda`, the resulting `Proc` will also be a
`lambda`.

### `Method#*`

```ruby
class Number
  def add(x, y)
    x + y
  end

  def double(x)
    x * 2
  end
end

(number.new.method(:double) * number.new.method(:add)).call(2, 3)
#=> 10
```

Composes a `Method` (`f`) with any object that responds to `call` (`g`)
returning a new `Proc` which will call `g` with any given arguments (including
blocks) and then call `f` with the result.

## Why isn't this in Ruby itself?

Good question: I'd like to [change](https://bugs.ruby-lang.org/issues/6284) [that](https://github.com/ruby/ruby/pull/935).

## License

Copyright © 2015 Paul Mucur.

Distributed under the MIT License.
