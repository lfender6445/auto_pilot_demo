
AutoPilot.configure do |config|
  # string or nil - your application key (optional, allows for more requests)
  config.key = nil
  # string - a stackoverflow jon-skeet
  config.user = 'jon-skeet'
  # integer - score must be greater than threshold in order to qualify for download
  config.score_threshold = 0
  # string - where to put markdown or html files
  config.folder = '_posts'
  # array - convert to [:md], [:html], or both eg [:md, :html]
  config.format = [:md]
  # boolean - prevent frontmatter from being added to markdown files
  config.disable_front_matter = false
  # integer - max pages when crawling paginated answers on your user page
  config.max_pages = 1
  # integer - time to wait between http requests (optional, eg 3 is 3 seconds)
  config.throttle = 3
end

module AutoPilot
  class MarkdownConverter

    def md_template
      @markdown ||= <<-BLOCK.unindent
      #{front_matter unless AutoPilot.configuration.disable_front_matter}
      #{h1_tag}
      #{answer}
      #{question}
      BLOCK
    end

  end
end

