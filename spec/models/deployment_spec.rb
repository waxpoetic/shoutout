require 'rails_helper'

RSpec.describe Deployment, type: :model do
  let :podcast do
    podcasts :brotherly_audio
  end

  let :episode do
    episodes :brotherly_audio_one
  end

  subject do
    Deployment.new podcast: podcast.decorate
  end

  before do
    allow(subject).to receive(:s3).and_return(
      double('AWS::S3', put_object: true)
    )
    allow(subject).to receive(:cloudfront).and_return(
      double('AWS::CloudFront', create_invalidation: true)
    )
  end

  it 'computes necessary attributes' do
    expect(subject.attributes.keys).to include(:acl)
    expect(subject.attributes.keys).to include(:bucket)
    expect(subject.attributes.keys).to include(:key)
    expect(subject.attributes.keys).to include(:body)
  end


  it 'persists to amazon' do
    allow(subject).to receive(:upload).and_return true
    allow(subject).to receive(:invalidate).and_return true
    expect(subject.save).to eq(true)
  end

  it 'uploads to s3' do
    expect(subject.send(:upload)).to eq(true)
  end

  it 'invalidates on cloudfront' do
    expect(subject.send(:invalidate)).to eq(true)
  end
end
