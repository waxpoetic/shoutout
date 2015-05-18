require "refile/s3"

# Upload assets to S3

aws = {
  access_key_id: Rails.application.secrets.aws_access_key_id,
  secret_access_key: Rails.application.secrets.aws_secret_access_key,
  region: "us-east-1",
  bucket: "brother.ly",
}

Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
Refile.host = "//brother.ly"
