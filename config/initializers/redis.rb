redis_config = YAML.load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]

begin
  $redis = Redis.new( :host => redis_config["host"], :port => redis_config["port"], :db => redis_config["db"] )
  $redis.ping
rescue
  raise "please install and start redis, install on MacOSX: 'sudo brew install redis', start : 'redis-server /usr/local/etc/redis.conf'"
end