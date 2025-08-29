# 代码生成时间: 2025-08-29 20:46:08
# file_backup_sync_tool.rb

require 'fileutils'
require 'digest'
require 'optparse'

# FileBackupSyncTool is a utility for backing up and synchronizing files between directories.
class FileBackupSyncTool
  # Initializes a new instance of FileBackupSyncTool with source and destination paths.
  def initialize(source_path, destination_path)
    @source_path = source_path
    @destination_path = destination_path
  end

  # Performs the backup and synchronization of files.
  def backup_and_sync
    # Check if the source path exists
    raise 'Source path does not exist' unless File.exist?(@source_path)

    # Create destination path if it does not exist
    FileUtils.mkdir_p(@destination_path) unless File.exist?(@destination_path)

    # Hash table to store the checksums of files in destination
    destination_checksums = {}

    # Iterate over each file in the source path
    Dir.glob(File.join(@source_path, '**', '*')).each do |file|
      next if File.directory?(file)

      # Calculate the checksum of the file
      file_checksum = Digest::MD5.file(file).hexdigest

      # Construct the destination file path
      relative_path = file.sub(@source_path, '').gsub(/^\//, '')
      dest_file = File.join(@destination_path, relative_path)

      # If the file does not exist in the destination or checksums do not match, copy the file
      unless File.exist?(dest_file) || destination_checksums[relative_path] == file_checksum
        FileUtils.cp(file, dest_file)
        puts "Copied #{relative_path}"
      end

      # Update the checksum for the destination file
      destination_checksums[relative_path] = file_checksum
    end
  end
end

# Parse command line options
options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: file_backup_sync_tool.rb [options]'

  opts.on('-s', '--source PATH', 'Source directory path') do |source|
    options[:source] = source
  end

  opts.on('-d', '--destination PATH', 'Destination directory path') do |destination|
    options[:destination] = destination
  end
end.parse!

# Check if source and destination paths are provided
if options[:source].nil? || options[:destination].nil?
  puts 'Please provide both source and destination paths.'
  exit
end

# Initialize and run the tool
tool = FileBackupSyncTool.new(options[:source], options[:destination])
tool.backup_and_sync
