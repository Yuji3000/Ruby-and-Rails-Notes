# String Methods

``` Ruby 
"12".match?(/[[:digit:]]/) #=> true
```

``` Ruby 
"twelve".match?(/[[:alpha:]]/) #=> true
```


# Enumerables

  - if you don't care what the argument/block variable is you can use _1
``` Ruby 

  array = [1, 2, 3]
  array.each { print "#{_1}" }  #=> 123
```

Map
  - will always return an array of the same size as the receiver
  - .map! will mutate the original data collection
``` Ruby
  arr = [1, 2, 3, 4]
  arr.map { |n| n * 2 }  #=> [2, 4, 6, 8]
```


## Tally
  - Creates a hash from an array, where keys = elements and values = count

``` Ruby
  ['apple', 'banana', 'apple', 'orange', 'banana', 'banana'].tally 
  #=> {"apple"=>2, "banana"=>3, "orange"=>1}
```

  Using tally with other enumberables

``` Ruby
  # Group numbers into ranges, then tally

  arr = [1, 5, 7, 10, 15, 20, 25, 30]

  arr.map do |n|
    case n
      when 1..10 then '1-10'
      when 11..20 then '11-20'
      else '21-30'
    end
  end.tally

  #=> {"1-10"=>4, "11-20"=>2, "21-30"=>2}
```

``` Ruby
  # Tally only even numbers, count others as 'odd'
  arr = [1, 2, 3, 4, 5, 6, 7, 8]

  arr.map { |n| n.even? ? 'even' : 'odd' }.tally
  # => {"odd"=>4, "even"=>4}

```

## Partition
  - Divides a collection into two arrays: one where the block is true and one where the block is false.
``` Ruby
  even, odd = [1, 2, 3, 4, 5, 6].partition { |n| n.even? }
  # even => [2, 4, 6]
  # odd => [1, 3, 5]
```

## Zip
  - Takes multiple arrays and merges them element-wise
``` Ruby
  a = [1, 2, 3]
  b = [4, 5, 6]
  a.zip(b)
  #=> [[1, 4], [2, 5], [3, 6]]
```

## Each with object

- A combination of iteration and accumulation. You pass an object (like a hash or array) to collect the results of the iteration.

``` Ruby
  [1, 2, 3, 4].each_with_object([]) { |n, arr| arr << n * 2 }
  #=> [2, 4, 6, 8]
```

``` Ruby
  # Example with hash

  ['apple', 'banana', 'cherry'].each_with_object({}) do |fruit, hash|
    hash[fruit] = fruit.length
  end
  #=> {"apple"=>5, "banana"=>6, "cherry"=>6}
```

## Any
- Checks if any of the items in the array/hash meet the requirements 
- Returns a boolean

``` Ruby
  array = [1, 2, 3, 2]
  array.any? { |num| num > 2} # => true
```

``` Ruby
  {foo: 0, bar: 1, baz: 2}.any?(Array)
  #=> true

  # Why is this true?
  # Ruby stores hash key-value pairs within arrays
  # e.g. {foo: 0, bar: 1, baz: 2}.to_a 
  # => [[:foo, 0], [:bar, 1], [:baz, 2]]


  {foo: 0, bar: 1, baz: 2}.each { |pair| p pair.class }
  # Output:
  # Array
  # Array
  # Array
```

## Minmax


``` Ruby

  a = ["kitty cat", "dog", "horse"]
  p a.minmax #=> ["kitty cat", "horse"]
  p a.minmax { |a, b| a.length <=> b.length } #=> ["dog", "kitty cat"]
```