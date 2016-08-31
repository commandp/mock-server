# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  def initialize(*)
    super
    if FileUploader.fog_settings_exist?
      self.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Setting.find_by(key: 's3_access_key_id'),
      :aws_secret_access_key  => Setting.find_by(key: 's3_secret_access_key'),
      }
      self.fog_directory = Setting.find_by(key: 's3_bucket')
    end
  end

  def self.fog_settings_exist?
    # FIXME 很蠢
    settings = []
    %w( s3_bucket s3_region s3_access_key_id s3_secret_access_key ).each do |attr|
      settings << Setting.find_by(key: attr)
    end
    settings.size == 4 && settings.map{ |setting| setting.try(:value) }.compact.size == 4
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
