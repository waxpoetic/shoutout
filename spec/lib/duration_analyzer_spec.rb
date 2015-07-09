require 'spec_helper'
require 'duration_analyzer'

RSpec.describe DurationAnalyzer, type: :lib do
  let :enclosure do
    double 'Enclosure', path: File.expand_path('./spec/fixtures/files/stream.flv')
  end

  let :episode do
    double 'Episode', enclosure: enclosure
  end

  let :duration do
    500
  end

  let :mediainfo do
    double 'Mediainfo', video?: true, video: double('VideoStream', duration: duration)
  end

  subject do
    DurationAnalyzer.new(enclosure)
  end

  before do
    allow(subject).to receive(:media).and_return(mediainfo)
  end

  it "uses the episode's enclosure to find the path" do
    expect(subject.file).to eq(enclosure)
  end

  it 'analyzes duration' do
    expect(subject.duration).to eq(duration)
  end

  it 'updates duration on episode' do
    allow(episode).to receive(:update_attributes).with(duration: duration).and_return(true)
    allow(DurationAnalyzer).to receive(:new).and_return(subject)
    expect(DurationAnalyzer.update(episode)).to eq(true)
  end
end
