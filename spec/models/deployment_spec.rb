require 'rails_helper'

RSpec.describe Deployment, type: :model do
  let :podcast do
    podcasts :brotherly_audio
  end

  subject do
    Deployment.new podcast: podcast
  end

  it 'computes necessary attributes' do
    expect(subject.attributes.keys).to include(:acl)
    expect(subject.attributes.keys).to include(:bucket)
    expect(subject.attributes.keys).to include(:key)
    expect(subject.attributes.keys).to include(:body)
  end

  it 'renders to xml' do
    expect(subject.to_xml).to include('<?xml')
  end

  it 'persists to amazon' do
    allow(subject).to receive(:upload).and_return true
    allow(subject).to receive(:invalidate).and_return true
    expect(subject.save).to eq(true)
  end

  it 'uploads to s3' do
    allow(subject).to receive(:s3).and_return(
      double('AWS::S3', put_object: true)
    )
    expect(subject.send(:upload)).to eq(true)
  end

  it 'invalidates on cloudfront' do
    allow(subject).to receive(:cloudfront).and_return(
      double('AWS::CloudFront', create_invalidation: true)
    )
    expect(subject.send(:invalidate)).to eq(true)
  end
end
