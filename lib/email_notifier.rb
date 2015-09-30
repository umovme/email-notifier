# encoding: UTF-8
require 'csv_hasher'
require 'open-uri'
require 'fileutils'
require 'yaml'
require 'logging'
require_relative './email_rule'

class EmailNotifier

  def initialize
    @logger = Logging.logger('log/notifier.log')
    @logger.level = :info
  end

  def load_email_rules_settings
    @@settings=YAML.load_file(File.join(File.dirname(__FILE__), '../conf/email_rules.yml'))
  end

  def run
    log_start_process
    load_email_rules_settings
    load_files.each do |filename|
      #process_file filename
    end
    log_finish_process
  end

  def process_file filename
    file = File.new(filename, "r")
    @logger.info "  Starting processing file #{File.absolute_path(file)}"
    load file
    file.close
  end

  def load_files
    file = 'files_to_process/*.csv'
    files = Dir[file]
  end

  def log_finish_process
    @logger.info "Downloads finished successfully!!"
    @logger.info "=========================================="
  end

  def log_start_process
    @logger.info "=========================================="
    @logger.info "Starting downloading photos process ... "
  end

  def load file
    counter = 0;
    begin
        while (line = file.gets)
            counter = counter + 1
            process_data(line, counter)
        end
        rename_file_to_processed file
    rescue => err
        @logger.info "Exception: #{err}"
        err
    end
  end

  def process_data file_line, counter
    
    rules = []
    rules_count=0

    csv = CSV.parse(file_line, :col_sep => ?;, headers: false)
    if( is_second_line counter )
        
        @logger.info "Reading reader"
        
        csv.each do |line|
            puts "Total of columns: #{line.inspect}"
            puts "\n"
            puts "Total of rules: #{load_email_rules_settings.length}"
            count_column = 0
            rule = EmailRule.new
            line.each do |column|

              
              load_email_rules_settings.each do |email_rule|
               
                validation = email_rule['condition']
                if ( column ==  validation)
                  rule.validation_index = count_column
                  puts "index: #{rule.validation_index}"
                end

                to = email_rule['to']
                if ( column ==  to)
                  rule.to_index = count_column
                  puts "index: #{rule.to_index}"
                end
              end
              count_column = count_column + 1
            end
            rules[rules_count] = rule
            rules_count = rules_count + 1
            puts "Rules: #{rules.length}"

        end
        return

     else
      puts rules.length
=begin
       csv.each do |line|
        puts "Deve enviar e-mail: #{line[@@validation_index.to_i]}"
        validated = line[@@validation_index.to_i]
        if( validated == 'true')
          load_email_rules_settings.each do |email_rule|
              to = email_rule['to']
              if ( column ==  validation)
                @@validation_index = count_column
                puts "index: #{@@validation_index}"
              end
          end
        end
       end
=end
    end

    if( is_last_line file_line)
        @logger.info "Last line ... download of photo finished successfully!!!\n"
        return
    end
    @logger.info "Processing line #{counter}"
  end

  def download_photos file_line
    csv = CSV.parse(file_line, :col_sep => ?;, headers: false)
    csv.each do |line|
      get_photos_position.each do |photo_position|
        @logger.info "Looking for photo in column #{photo_position}"
        download_photo line, photo_position
      end
    end
  end

  def download_photo line, photo_position
    begin
         photo_url=line[photo_position]
         if (photo_url and is_photo photo_url)
            @logger.info "Found record with photo #{photo_url}"
            build_photo photo_url, line
         else
            @logger.info "No photo found"
         end

      rescue => err
          @logger.info "Error while downloading photo: #{err}"
      end
  end

  def build_photo photo_url, column
      photo_name = extract_photo_name photo_url
      customer_identifier = first_level_photo_folder column
      execution_date = second_level_photo_folder column
      customer_photo_folder = "#{photo_path}/#{customer_identifier}/#{execution_date}"
      FileUtils::mkdir_p customer_photo_folder
      open(photo_url) { |f|
          File.open("#{customer_photo_folder}/#{photo_name}.jpg","wb") do |file|
              file.puts f.read
          end
      }
  end

  def extract_photo_name photo_url
      initial_index = photo_url.index("?")
      final_index = photo_url.index("&")
      photo_url[initial_index + 4 .. final_index - 1 ]
  end

  def is_second_line counter
    counter == 2
  end

  def is_last_line line
    count_column=line.split(";").length
    count_column < 2 and line.include? "FIM;"
  end

  def is_photo photo_url
    photo_url.include? "http://picviewer" 
  end

  def first_level_photo_folder row
      index_first_level_photo_folder = @@settings['index_first_level_photo_folder']
      row[index_first_level_photo_folder]
  end

  def second_level_photo_folder row
    index_second_level_photo_folder = @@settings['index_second_level_photo_folder']
    row[index_second_level_photo_folder]
  end

  def get_photos_position
    @@settings['indexes_photo_url']
  end

  def rename_file_to_processed file
    original_filename = File.absolute_path(file)
    filename_processed = "#{File.absolute_path(file)}.processado"
    @logger.info "Renomeando arquivo ...#{original_filename} para #{filename_processed}"
    File.rename(original_filename, filename_processed)
  end

end