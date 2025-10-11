# 代码生成时间: 2025-10-11 21:59:49
# dns_resolver_cache.rb
# This Ruby script provides a simple DNS resolver with caching functionality.
# It's designed to resolve domain names to IP addresses and cache the results to reduce
# the number of DNS queries for frequently requested domains.

require 'resolv'
require 'memoist'

class DNSResolverCache
  include Memoist
  
  # Initializes the DNSResolverCache with a cache store
  def initialize
    @cache = {}
  end

  # Resolves a domain name to an IP address and caches the result
  #
  # @param domain [String] The domain name to resolve
  # @return [String] The IP address of the domain
  def resolve(domain)
    # Check if the domain is already cached
    return @cache[domain] if @cache[domain]
    
    begin
      # Perform DNS resolution using the Resolv library
      ip_address = Resolv.getaddress(domain)
      
      # Cache the result for future requests
      @cache[domain] = ip_address
    rescue Resolv::ResolvError => e
      # Handle DNS resolution errors
      puts "Error resolving domain '#{domain}': #{e.message}"
      nil
    end
  end

  # Clears the cache for a specific domain
  #
  # @param domain [String] The domain to clear from the cache
  def clear_cache(domain)
    @cache.delete(domain)
  end

  # Clears the entire cache
  def clear_all_cache
    @cache.clear
  end

private
  # Memoist is automatically used to cache method results
  memoize :resolve
end

# Example usage:
if __FILE__ == $0
def main
  resolver = DNSResolverCache.new
  puts "Resolving 'google.com': #{resolver.resolve('google.com')}"
  puts "Resolving 'google.com' again (should use cache): #{resolver.resolve('google.com')}"
  resolver.clear_cache('google.com')
  puts "After clearing cache, resolving 'google.com': #{resolver.resolve('google.com')}"
end

main
end