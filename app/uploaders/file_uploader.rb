# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  def initialize(*)
    super
    # FIXME 很蠢
    if Setting.by_key('s3_bucket').present? && Setting.by_key('s3_region').present? && Setting.by_key('s3_access_key_id').present? && Setting.by_key('s3_secret_access_key').present?
      self.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Setting.by_key('s3_access_key_id'),
      :aws_secret_access_key  => Setting.by_key('s3_secret_access_key'),
      }
      self.fog_directory = Setting.by_key('s3_bucket')
    end
  end

  def self.set_storage
    if Configuration.use_cloudfiles?
      :fog
    else
      :file
    end
  end

  storage set_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


end
