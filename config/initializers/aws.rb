if Rails.env.production?
  Aws.config.update(Rails.application.secrets.aws)
end
