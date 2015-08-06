require "share_counter/version"
require "rest-client"
require "json"

module ShareCounter
  def self.twitter url
    html = make_request "http://urls.api.twitter.com/1/urls/count.json",  url: url
    return JSON.parse(html)['count']
  end

  def self.facebook url
    html = make_request "https://api.facebook.com/method/links.getStats",  urls: url, format: "json"
    return JSON.parse(html, symbolize_names: true)[0]
  end

  def self.reddit url
    html = make_request "http://www.reddit.com/api/info.json", url: url
    j = JSON.parse(html)

    unless j['data']['children'].empty?
      return j['data']['children'][0]['data']['score']
    else
      return 0
    end
  end

  def self.linkedin url
    html = make_request "https://www.linkedin.com/countserv/count/share", url: url, callback: "IN.Tags.Share.handleCount"
    return JSON.parse(html)['count']
  end

  def self.stumbleupon url
    html = make_request "http://www.stumbleupon.com/services/1.01/badge.getinfo", url: url

    if not JSON.parse(html)['success'] or not JSON.parse(html)['result']['views']
      return 0
    end

    return JSON.parse(html)['result']['views']
  end

  def self.pinterest url
    html = make_request "http://widgets.pinterest.com/v1/urls/count.json", url: url, source: 6
    html.gsub! 'receiveCount(', ''
    html.gsub! ')', ''
    return JSON.parse(html)['count']
  end

  def self.supported_networks
    %w(reddit twitter facebook linkedin stumbleupon pinterest)
  end

  def self.all url
    supported_networks.inject({}) { |r, c| r[c.to_sym] = ShareCounter.send(c, url); r }
  end

  def self.selected url, selections
    selections.map{|name| name.downcase}.select{|name| supported_networks.include? name.to_s}.inject({}) {
       |r, c| r[c.to_sym] = ShareCounter.send(c, url); r }
  end

  private

  def self.make_request *args
    result   = nil
    attempts = 1
    url      = args.shift
    params   = args.inject({}) { |r, c| r.merge! c }

    begin
      response = RestClient.get url, { params: params, timeout: 5 , ssl: { verify_ssl: false } }
      result = params.keys.include?(:callback) \
        ? response.gsub(/\A\/\*\*\/\s+/, "").gsub(/^(.*);+\n*$/, "\\1").gsub(/^#{params[:callback]}\((.*)\)$/, "\\1") \
        : response
    rescue => e
      puts "Failed #{attempts} attempt(s) - #{e}"
      attempts += 1
      if attempts <= 3
        sleep 2
        retry
      else
        raise e
      end
    end

    result
  end
end
