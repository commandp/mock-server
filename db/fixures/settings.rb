%w( s3_bucket s3_region s3_access_key_id s3_secret_access_key ).each do |attr|
  Setting.seed_once(:key) do |setting|
    setting.key  = attr
  end
end
