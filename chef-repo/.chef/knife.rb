repo_dir = File.join(File.dirname(__FILE__), "..")

log_level               :info
chef_repo_path          repo_dir
local_mode              true

# AWS things
# knife[:aws_access_key_id]      = Settings::AWS_ACCESS_KEY
# knife[:aws_secret_access_key]  = Settings::AWS_SECRET
# knife[:aws_ssh_key_id]         = Settings::AWS_SSH_KEY
# knife[:region]                 = "us-east-1"
