$:.push File.join(File.dirname(__FILE__), '..', 'lib')
$:.push File.join(File.dirname(__FILE__), '..', 'app', 'models')

# This script loads the jobs cache by querying job posts from Bullhorn
# and saving them locally.  Note: the jobs are returned as XML, parsed,
# and saved in the cache as YAML for faster retrieval.
#
# This script is expected to be called by a cron: e.g. $ruby load_jobs_cache.rb

require 'bullhorn_gateway'
require 'yaml'

# gateway to request job xml
gw = BullhornGateway.new(File.join(File.dirname(__FILE__), '..', 'data'))
# perform request and save to cache
gw.job_posts_to_cache

exit
