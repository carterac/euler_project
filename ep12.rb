# What is the first triangle number to have over 500 divisors?

# Return the nth triangle number
def triangle(n)
  return (n.to_f**2)/2 + n.to_f/2
end


# Returns number of divisors in n based on its prime factors
# Returns divisors very fast (I'm guessing around O(log(log(n))) time) once you've calculated prime factors
def num_divisors(n)

  prime_factors = calculate_prime_factors(n)

  if prime_factors.size == 0
    return 2
  end
  
  # Key insight: The number of divisors is equivalent to the number of ways you can separate
  # n's prime factors into two non-null distinct sets
  # Number of distinct sets double for every new prime factor. If there are 2 of the same prime factor
  # the number of distinct sets increases by 3, and then 4 for 3 of the same prime factor etc..
  # 
  # For example, 60 prime factors are 2, 2, 3, and 5. 
  # So number of distinct sets = 3 (two 2's) x 2 (one 3) x 2 (one 5) = 12
  i = 0
  num_divisors = 1
  while i <= prime_factors.size-1
    i = i + 1
    multiple = 2
    while prime_factors[i] == prime_factors[i-1]
      multiple = multiple + 1
      i = i + 1
    end
    num_divisors = num_divisors * multiple
  end
  
  return num_divisors
  
end
  
# Returns an array of all the prime factors of n
# Keeps global array primes[] updated to avoid calculating primes twice
# Pretty fast. Only check up to the sqrt(n) max and only checks primes
# If primes are pre-generated (only needs to happen once) worst case time is O(sqrt(n) / log(sqrt(n))
def calculate_prime_factors(n)
  
  square_root_of_n = n**0.5
  prime_factors = []
  
  if $primes.last == nil
    $primes<<2
  end
  
  # Divide n by all primes in primes[]
  for prime in $primes

    # But don't waste time going past the sqrt(n)
    if prime > square_root_of_n
      break
    end
    
    # If a prime divides n, add it to prime_factors
    if n % prime == 0
      
      multiple_prime_count = 2
      prime_factors<<prime
      
      # Divide n by the prime factor
      # This is OK because the only prime factors left in n will be bigger than prime
      n = n/prime
      
      # Keep dividing for multiple of the same prime factor
      while n % prime == 0
        n = n/prime
        prime_factors<<prime
      end
      
      # Update the new square root of n that we care about for checking prime factors
      square_root_of_n = n**0.5
  
    end
    
    # If the last prime in primes is less than sqrt(n) add the next prime to primes
    if prime == $primes.last && prime < square_root_of_n
      $primes<<get_next_prime(prime)
    end

  end
  
  # Whatever is left must be a prime factor if it's greater than 1
  if n > 1
    prime_factors<<n
  end
    
  return prime_factors 
end

  
# Returns the next prime after n. Uses primes array to help. 
def get_next_prime(n)
  
  #make sure primes[] has all primes up to sqrt(n)
  if $primes.last == nil
    $primes = prime_numbers_up_to(n**0.5)
  elsif $primes.last < n**0.5
    $primes = prime_numbers_up_to(n**0.5)
  end
  
  # Make sure to start in the positives
  if n < 1
    n = 1
  end
  
  # Check consecutive numbers i until a prime is found
  i = n
  is_prime = false
  while is_prime == false

    i = i + 1
    sqrt_i = i**0.5
    is_prime = true
    
    for prime in $primes
      
      # No need going past the sqrt
      if prime > sqrt_i
        break
      end
      
      # Break once you've found a divisor
      if i % prime == 0 
        is_prime = false
        break
      end
      
    end    
  end
  
  return i
  
end

$primes = []

# Print out the first number with over 500 divisors
# Opportunity for further speed improvement by using a binary search function for i
i = 1
num = 0
while num < 500
  triangle = triangle(i)
  num = num_divisors(triangle)
  puts triangle.to_s + " has " + num.to_s + " divisors"
  i = i + 1
end


#returns array of primes up to n building upon an existing array of primes if possible
#this assumes primes contains only primes, in ascending order, with none missing
# def prime_numbers_up_to(n)
#   
#   puts "does this get called? yes if you're seeing this"
#   
#   #initialize primes if it's empty, otherwise start i after the biggest prime in primes
#   if $primes.last == nil
#     $primes<<2
#     i = 3
#   else
#     i = $primes.last + 1
#   end
#   
#   while i <= n
# 
#     sqrt_i = i**0.5
#     is_prime = true
#     
#     for prime in $primes
#       
#       if prime > sqrt_i
#         break
#       end
#       
#       if i % prime == 0 
#         is_prime = false
#         break
#       end
#     end
#     
#     if is_prime
#       $primes<<i
#       puts i.to_s
#     end
#     
#     i = i + 1
#     
#   end
#   
#   return $primes
#   
# end
# 
