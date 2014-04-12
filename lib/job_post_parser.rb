
require 'rexml/document'
require 'date'

# parses job post xml returned by bullhorn
class JobPostParser

  def initialize(xml)
    @xml = xml
  end

  # parse bullhorn XML and return array of job posts
  def parse_job_posts
    job_posts = JobPosts.new
    doc = REXML::Document.new @xml

    doc.elements.each("root/job") do |elem|
      id = elem.elements["JOBPOSTINGID_INT"].text.to_i
      location = elem.elements["CITY_STRING"].text
      title = elem.elements["TITLE_STRING"].text
      employment_type = elem.elements["EMPLOYMENTTYPE_STRING"].text
      description = elem.elements["PUBLICDESCRIPTION_STRING"].text
      date = Date.parse(elem.elements["DATEADDED_DATE"].text)

      job_posts << JobPost.new(id, location, title, employment_type, description, date)
    end

    return job_posts
  end
end
