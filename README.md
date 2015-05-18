# Shoutout

Shoutout is a podcast management web application that provides a slick
interface for uploading new podcast episodes and "deploying" feeds to an
Amazon S3 bucket. It was built to manage the
[brother.ly](http://github.com/waxpoetic/brother.ly) podcast with a
simple and elegant interface, while maintaining scalability under
high traffic. To accomplish this, the entire podcast, including both
media and the feed, are served off of the Amazon CloudFront CDN. This
application is used to build the podcast feed with valid links to each
episode file, then upload that feed to S3 where it will be served to
CloudFront edge locations.

## Setup

Install PostgreSQL, then clone this repo and run `./bin/setup`.

## Usage

Start the server with `./bin/rails server`, then log on as
**admin@example.com** to begin uploading podcasts. Users can not
register for this application, you will need to manually add them in the
"Users" tab.

Podcasts can be created and destroyed, but podcast feeds are not
automatically managed. You must delete the podcast feed off of Amazon S3
to ensure that it can no longer be reached. However, if episodes are
deleted from a podcast, their files are also removed from S3.

## Development

Contributions are welcome so long as they include both acceptance and
unit tests, and they are made within a GitHub pull request. To execute
the entire test suite, run `./bin/rake test`.
