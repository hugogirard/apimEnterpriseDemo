param location string
param suffix string

resource redisCache 'Microsoft.Cache/redis@2023-08-01' = {
  name: 'redis-${suffix}'
  location: location
  properties: {
    enableNonSslPort: false
    sku: {
      name: 'Basic'
      family: 'C'
      capacity: 0
    }    
  }
}

output redisCacheName string = redisCache.name 
