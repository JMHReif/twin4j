require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

require 'webdriver-user-agent'
require 'selenium-webdriver'
require 'open-uri'

include ::Asciidoctor

# A block macro that embeds a Tweet into a document
#
# Usage
#
#   tweet::12345[]
#
class TwitterBlockMacro < Extensions::BlockMacroProcessor
  use_dsl

  named :tweet

  def process parent, target, attrs

    if attrs["type"] == "web"
      response = open("https://publish.twitter.com/oembed?url=https://twitter.com/twin4j/status/#{target}").read
      inner_html = JSON.parse(response)["html"]

      html = %(<div class="content">
      #{inner_html}
      </div>)
    else
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--ignore-certificate-errors')
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--disable-translate')
      options.add_argument('--user-agent=iphone')
      options.add_argument('--window-size=414,600')

      image_location = "adoc/images/twitter/#{target}.png"
      tweet_location = "https://twitter.com/twin4j/status/#{target}"
      s3_location = "https://s3-eu-west-1.amazonaws.com/twin4j-newsletter-images/twitter/#{target}.png"

      driver = Selenium::WebDriver.for :chrome, options: options
      driver.navigate.to tweet_location
      driver.save_screenshot image_location
      driver.quit

      html = %(<div class="content">
      <a class="image" href="#{tweet_location}" target="_blank">
        <img src="#{s3_location}" width="100%" />
      </a>
      </div>)
    end

    create_pass_block parent, html, attrs, subs: nil

  end
end
