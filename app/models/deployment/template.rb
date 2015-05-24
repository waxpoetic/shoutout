class Deployment
  class Template
    def initialize(deployment)
      @podcast = deployment.podcast
    end

    def to_xml
      template.result(binding)
    end

    private

    def template
      ERB.new file
    end

    def file
      File.read "#{Rails.root}/lib/templates/podcast.xml.erb"
    end
  end
end

