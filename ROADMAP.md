# Taylor Roadmap

## 3.12

- Support native OSX Apple architecture support for exports
- Upgrade to mruby 3.2.0-rc

## 3.13

- Finish shader implementation for 2D

## 3.14

- Finish Android support

## 4.0

- Get rid of the `load` methods in favour of just doing it in `new` for
  resources as we'll never want to manually create them (or at least if we do
  it's not going to be the most common way of using these objects)
