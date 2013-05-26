#What is the first triangle number to have over 500 divisors?

def triangle(n)
  return (n.to_f**2)/2 + n.to_f/2
end


#returns number of divisors in n based on its prime factors
def num_divisors(n)

  prime_factors = calculate_prime_factors(n)

  if prime_factors.size == 0
    return 2
  end
  
  #The number of divisors is equivalent to the number of ways you can separate
  #n's prime factors into two non-null distinct sets
  #except you have to subtract 2 since you can't have a null set
  #but then you have to add 2 to account for the divisors n and 1
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
  
#returns an array of all the prime factors of n
def calculate_prime_factors(n)
  
  square_root_of_n = n**0.5
  prime_factors = []
  
  if $primes.last == nil
    $primes<<2
  end
  
  #divide n by all primes in primes[]
  for prime in $primes

    #but don't waste time going past the sqrt(n)
    if prime > square_root_of_n
      break
    end
    
    #if a prime divides n, add it to prime_factors
    if n % prime == 0
      
      multiple_prime_count = 2
      prime_factors<<prime
      
      #divide n by the prime factor
      #this is OK because the only prime factors left in n will be bigger than prime
      n = n/prime
      
      #keep dividing for multiple of the same prime factor
      while n % prime == 0
        n = n/prime
        prime_factors<<prime
      end
      
      #update the new square root of n that we care about for checking prime factors
      square_root_of_n = n**0.5
  
    end
    
    #if the last prime in primes is less than sqrt(n) add the next prime to primes
    if prime == $primes.last && prime < square_root_of_n
      $primes<<get_next_prime(prime)
    end

  end
  
  #whatever is left must be a prime factor if it's greater than 1
  if n > 1
    prime_factors<<n
  end
    
  return prime_factors 
end

  
#returns the next prime after n. Uses primes array to help. 
def get_next_prime(n)
  
  #make sure primes[] has all primes up to sqrt(n)
  if $primes.last == nil
    $primes = prime_numbers_up_to(n**0.5)
  elsif $primes.last < n**0.5
    $primes = prime_numbers_up_to(n**0.5)
  end
  
  #make sure to start in the positives
  if n < 1
    n = 1
  end
  
  #keeping checking consecutive numbers until a prime is found
  i = n
  is_prime = false
  while is_prime == false

    i = i + 1
    sqrt_i = i**0.5
    is_prime = true
    
    for prime in $primes
      
      #no need going past the sqrt
      if prime > sqrt_i
        break
      end
      
      #break once you've found a divisor
      if i % prime == 0 
        is_prime = false
        break
      end
      
    end    
  end
  
  return i
  
end

array = [2,3,5,7,11,13,17,19,23,29]
empty_array = []
$primes = []

i = 1
num = 0
while num < 1000
  triangle = triangle(i)
  num = num_divisors(triangle)
  puts triangle.to_s + " has " + num.to_s + " divisors"
  i = i + 1
end

#puts prime_numbers_up_to(50, empty_array)
      
#puts prime_factors(60, empty_array)

#puts get_next_prime(17, empty_array)

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
