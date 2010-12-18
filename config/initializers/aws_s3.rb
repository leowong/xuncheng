# encoding: utf-8
aws_s3_file = File.join(File.dirname(__FILE__), '..', 'aws_s3.yml')

if File.exists?(aws_s3_file)
  AWS_S3 = YAML.load_file(aws_s3_file)[Rails.env]
else
  AWS_S3 = {}
end
