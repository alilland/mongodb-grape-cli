require "grape/cli/mongodb/version"
require 'optparse'
require 'fileutils'

module Grape
  module Cli
    module Mongodb

      def self.execute
        options = {}

        optparse = OptionParser.new do |opts|
          opts.banner = "Usage: grape [command] \"PROJECT_NAME\" [options]"

          opts.on( '-h', '--help', 'Display this screen' ) do
            puts opts
            exit
          end

          options[:project_name] = nil
          opts.on( '-n', '--new PROJECT_NAME', 'Generate New Project' ) do |project|
            options[:project_name] = project.downcase
          end

          # Define the options, and what they do
          options[:verbose] = false
          opts.on( '-v', '--verbose', 'Output more information' ) do
            options[:verbose] = true
          end
        end

        # Parse the command-line. the 'parse!' method parses ARGV and removes
        # any options found there, as well as any parameters for
        # the options.
        optparse.parse!

        if options[:project_name]
          puts "Generating new project #{options[:project_name]}"
          new_project( filepath: Dir.pwd, project: options[:project_name], verbose: options[:verbose] )
        end
      end

      def self.new_project(filepath: nil, project: nil, verbose: false)

        boilerplate = File.join( File.dirname(__FILE__), '/boilerplate' )

        ## Copy the boilerplate directory to the filepath
        FileUtils.cp_r(boilerplate, filepath)

        ## rename the boilerplate directory to the project name
        FileUtils.mv( "#{filepath}/boilerplate", "#{filepath}/#{project}" )

        new_path = "#{filepath}/#{project}"

        until File.directory?(new_path)
          print '.'
        end

        file_names = ['/init.rb', '/config.ru', '/config/entities.rb']
        file_names.each do |file_name|
          text = File.read( File.join(new_path, file_name) )
          replace_module = text.gsub('BOILERPLATE', project.upcase.gsub('_', ''))
          File.open(File.join(new_path, file_name), 'w') { |file| file.puts replace_module }
          puts "created file ./#{file_name}"
        end

        config_files = ['/config/mongoid.yml']
        config_files.each do |file_name|
          text = File.read( File.join(new_path, file_name) )
          replace_db = text.gsub( 'boilerplate', project )
          File.open( File.join(new_path, file_name), 'w' ) { |file| file.puts replace_db }
          puts "created file ./#{file_name}"
        end

        folders_to_make = ['entities', 'lib', 'log', 'bin', 'models', 'resources', 'tasks']
        folders_to_make.each do |folder|
          Dir.mkdir( File.join(new_path, folder) )
          puts  "created directory ./#{folder}"
        end
        ## create emty folders
        ## entities
        ## lib
        ## log
        ## bin
        ## models
        ## resources
        ## tasks

      end

    end
  end
end
