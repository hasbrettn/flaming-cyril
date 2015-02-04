def factorial(n)
  if n == 0
    return 1
  else
    return n * factorial(n - 1)
  end
end

# (1..10).each {|number| puts factorial(number)}