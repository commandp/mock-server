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
    Setting.find_by(key: 's3_bucket').value.present? && Setting.find_by(key: 's3_region').value.present? && Setting.find_by(key: 's3_access_key_id').value.present? && Setting.find_by(key: 's3_secret_access_key').value.present?   
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
