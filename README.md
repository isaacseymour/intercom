# Intercom local users task

### Requirements

- Ruby (tested on 2.6)
- Bundler
- `bundle install` and off you go

### How it works

There's two models involved:
- `SpherePoint` holds a lat/lng pair (in degrees), and handles all the maths: conversion to radians,
  calculating the central angle, and the distance (which requires knowing the sphere radius).
- `User` is a friendly representation of a line in the input JSON. It holds the name, ID, and their
  location

The logic for the task lives in `Task`. This is configured with:
- the radius of the sphere (6371km for the Earth)
- the central point of reference (the Intercom Dublin office)
- the max distance from that point (100km)

Its `#call` method takes a file, reads in each line, filters down to only those which
match the config, and returns their `#{name} (#{id})` as an array of strings.

To deal with the commandline, there's an executable `bin/task`. This takes two arguments:
- the input path (`-` for standard input)
- the output path (defaulting to standard output)

I've run
```bash
curl https://s3.amazonaws.com/intercom-take-home-test/customers.txt | bin/task - results.txt
```
and committed results.txt
