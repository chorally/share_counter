require 'spec_helper'

describe ShareCounter do
	let(:url) {'http://www.chorally.com'}

  it 'has a version number' do
    expect(ShareCounter::VERSION).not_to be nil
  end

  it 'get twitter shares count > 0' do
    share_counter = ShareCounter.twitter url
    expect(share_counter).to be > 0
  end

  it 'get facebook shares count > 0' do
    share_counter = ShareCounter.facebook url
    expect(share_counter[:share_count]).to be > 0
  end

  it 'get stumbleupon shares count = 0' do
    share_counter = ShareCounter.stumbleupon url
    expect(share_counter).to equal(0)
  end
end
