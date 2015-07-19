require 'yard-restful/tags/param_tag'

# Define custom tags
tags = [
  ["Declaration of RESTful API type",:restful_api],
  ["URL",                           :url],
  ["HTTP-Action for the Resource",  :action],

  #["Object Used in Resource",       :resource_object],
  ["Resource Object Property",      :attr, :with_types_and_name],
  ["Resource Object Association",   :association, :with_types_and_name],
  ["Resource Object Example",       :example],

  ["Required Arguments",            :required,          :with_types_and_name],
  ["Optional Arguments",            :optional,          :with_types_and_name],

  ["Example Request",               :example_request],
  ["Example Request Description",   :example_request_description],
  ["Request Fields",                :request_field,     :with_types_and_name],

  ["Example Response",              :example_response],
  ["Example Response Description",  :example_response_description],
  ["Response Fields",               :response_field,    :with_types_and_name],
  ["Response Type",                 :response,    :with_types],
  ['Request Attribute',             'resource.param', YardRestful::Tags::ParamTag]
]

tags.each do |tag|
    YARD::Tags::Library.define_tag(*tag)
end
