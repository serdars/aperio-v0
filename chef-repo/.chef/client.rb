repo_dir = File.join(File.dirname(__FILE__), "..")
log_level                   :info
chef_repo_path              repo_dir
local_mode                  true
encrypted_data_bag_secret   File.join(repo_dir, ".chef", "secrets", "encrypted_data_bag_secret")
