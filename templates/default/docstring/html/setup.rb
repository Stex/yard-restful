def init
  @markdown = YardRestful.initialize_markdown
  return if object.docstring.blank?
  sections :text
end
