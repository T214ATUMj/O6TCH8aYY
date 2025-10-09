# 代码生成时间: 2025-10-10 00:00:29
# version_control_system.rb
# This is a simple version control system written in Ruby using basic file operations.

require 'digest'

class VersionControlSystem
  # Initialize the repository directory
  def initialize(repo_dir = './repo')
    @repo_dir = repo_dir
    create_repo if Dir.exist?(@repo_dir) == false
  end

  # Create a new repository by setting up the initial files
  def create_repo
    FileUtils.mkdir_p(@repo_dir)
    FileUtils.touch(File.join(@repo_dir, 'HEAD'))
    FileUtils.touch(File.join(@repo_dir, 'index'))
  end

  # Add a file to the index (staging area)
  def add(file_path)
    unless File.exist?(file_path)
      raise "File #{file_path} does not exist."
    end
    file_content = File.read(file_path)
    file_hash = Digest::SHA256.hexdigest(file_content)
    File.open(File.join(@repo_dir, 'index'), 'a') { |f| f.puts(file_hash) }
  end

  # Commit the changes to the repository by creating a new snapshot
  def commit(message)
    timestamp = Time.now.to_s
    File.open(File.join(@repo_dir, 'HEAD'), 'w') { |f| f.puts(timestamp + "
" + message) }
    snapshot = create_snapshot
    File.open(File.join(@repo_dir, 'commits', snapshot), 'w') { |f| f.puts(snapshot) }
  end

  # Create a snapshot of the current index
  def create_snapshot
    snapshot_name = "snapshot-" + Time.now.to_i.to_s
    FileUtils.mkdir_p(File.join(@repo_dir, 'snapshots'))
    FileUtils.cp(File.join(@repo_dir, 'index'), File.join(@repo_dir, 'snapshots', snapshot_name))
    snapshot_name
  end

  # Checkout a specific snapshot
  def checkout(snapshot_name)
    if File.exist?(File.join(@repo_dir, 'snapshots', snapshot_name))
      FileUtils.rm_rf(@repo_dir, secure: true)
      FileUtils.cp_r(File.join(@repo_dir, 'snapshots', snapshot_name), @repo_dir)
    else
      raise "Snapshot #{snapshot_name} does not exist."
    end
  end

  # Log the commits
  def log
    Dir.glob(File.join(@repo_dir, 'commits', '*')).each do |file|
      puts File.read(file)
    end
  end

  # Revert the changes (reset the index)
  def revert
    FileUtils.touch(File.join(@repo_dir, 'index'))
  end
end

# Example usage:
# vcs = VersionControlSystem.new('my_repository')
# vcs.add('path/to/your/file.txt')
# vcs.commit('Initial commit')
# vcs.log
# vcs.checkout('snapshot-1234567890')
# vcs.revert