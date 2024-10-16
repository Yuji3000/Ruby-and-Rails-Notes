# String Methods

``` Ruby 
"12".match?(/[[:digit:]]/) # => true
```

``` Ruby 
"twelve".match?(/[[:alpha:]]/) # => true
```


# Enumerables

  - if you don't care what the argument/block variable is you can use _1
``` Ruby 

  array = [1, 2, 3]
  array.each { print "#{_1}" }  # => 123
```

Map
  - will always return an array of the same size as the receiver
``` Ruby
  arr = [1, 2, 3, 4]
  arr.map { |n| n * 2 }  #  => [2, 4, 6, 8]
```


Tally
  - creates a hash from an array keys = elements, values = count
``` Ruby
  ['apple', 'banana', 'apple', 'orange', 'banana', 'banana'].tally 
  # => {"apple"=>2, "banana"=>3, "orange"=>1}

```

Partition
  - divides a collection into two arrays: one where the block is true and one where the block is false.
``` Ruby
  even, odd = [1, 2, 3, 4, 5, 6].partition { |n| n.even? }
  # even => [2, 4, 6]
  # odd => [1, 3, 5]
```

Zip
  - takes multiple arrays and merges them element-wise
``` Ruby
  a = [1, 2, 3]
  b = [4, 5, 6]
  a.zip(b)
  #  => [[1, 4], [2, 5], [3, 6]]
```

Each with object

- a combination of iteration and accumulation. You pass an object (like a hash or array) to collect the results of the iteration.
``` Ruby
  [1, 2, 3, 4].each_with_object([]) { |n, arr| arr << n * 2 }
  # => [2, 4, 6, 8]
```
