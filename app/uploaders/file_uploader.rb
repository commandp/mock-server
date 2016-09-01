# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  def initialize(*)
    super
    if FileUploader.fog_settings_exist?
      self.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY']
      }
      self.fog_directory = ENV['S3_BUCKET']
    end
  end

  def self.fog_settings_exist?
    # FIXME 很蠢
    settings = []
    %w( S3_BUCKET S3_REGION S3_ACCESS_KEY_ID S3_SECRET_ACCESS_KEY ).each do |attr|
      settings << ENV[attr]
    end
    settings.compact.size == 4
  end

  def self.set_storage
    if self.fog_settings_exist?
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
