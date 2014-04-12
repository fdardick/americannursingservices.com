require 'net/http'
require 'net/https'
require 'job_post_parser'
# needed to deserialize objects from cache file
require 'job_posts'
require 'job_post'

class BullhornGateway

  # api keys provided by bullhorn custom for ANS
  ENCRYPTED_API_KEY = "%23%262%5F%2C%0A"
  PRIVATE_LABEL_ID = "415"
  BULLHORN_DOMAIN = "www.bullhornstaffing.com"

  def initialize(cache_dir)
  # cached xml file with job postings from bullhorn
  @job_post_cache_file = File.join(cache_dir, 'jobs.yaml')

  end

  # Obtains current job postings from bullhorn and returns them
  # as an Array of JobPosts
  def job_posts

    job_posts_as_xml = query_all_job_posts
    # parse xml
    parser = JobPostParser.new(job_posts_as_xml)
    job_posts = parser.parse_job_posts

    return job_posts
  end

  def job_post(job_id)
    job_post_as_xml = query_job_post(job_id)
    parser = JobPostParser.new(job_post_as_xml)
    job_post = parser.parse_job_posts[0]

    return job_post
  end

  # load job post from previously saved cache; assume cache refreshed frequently
  def job_posts_from_cache
    return YAML::load(File.read(@job_post_cache_file))
  end

  # creates a cache of job posts after querying latest set from gateway.  Cache
  # is in yaml format for performance reasons.
  def job_posts_to_cache
    job_posts_as_xml = query_all_job_posts
    parser = JobPostParser.new(job_posts_as_xml)
    job_posts = parser.parse_job_posts
    if job_posts.size > 0
      puts "#{Time.now} - Loaded #{job_posts.size} Jobs."
      File.open(@job_post_cache_file, 'w').write job_posts.to_yaml
    else
      # TODO: improve error notification
      puts "Error: No Jobs received from Bullhorn.  Notify davidpthomas@gmail.com"
    end
  end

  private

  # query all posts
  def query_all_job_posts
    perform_query   # returns all by default
  end

  # query single job post
  def query_job_post(job_id)
    perform_query("&filterColumn1=jobPostingId&filter1=#{job_id}")
  end

  # Contact bullhorn service and return raw job posts xml.
  # Extra url parameters can be optionally provided to filter search.
  def perform_query(extra_params = nil)
    path = "/BullhornStaffing/API/PublicJobPostingsXML.cfm"
    get_string = "privateLabelID=#{PRIVATE_LABEL_ID}&encryptedAPIKey=#{ENCRYPTED_API_KEY}"
    get_string += extra_params if !extra_params.nil?

    # TODO: error handling
    resp = Net::HTTP.get(BULLHORN_DOMAIN, "#{path}?#{get_string}")

    xml = resp
    return xml

  end
end

