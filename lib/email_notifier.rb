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
      puts 'running'
      process_file filename
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
    @logger.info "Emails successfully sent!!"
    @logger.info "=========================================="
  end

  def log_start_process
    @logger.info "=========================================="
    @logger.info "Starting sending email process ... "
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
    @logger.info "Processing line #{counter}"
    if( is_first_line counter or is_last_line file_line)
      @logger.info "Discarting first/last line\n"
      return
    end
    
    if( is_second_line counter )
      @logger.info "Loading header rules!!\n"
      @@email_rules = load_email_rules file_line
      return
    end

    @@populated_emails = build_emails file_line, @@email_rules
    send_emails @@populated_emails

  end

  def build_emails line, email_rules

    email_rules.each do |email_rule|

      csv_line = CSV.parse(line, :col_sep => ?;, headers: false) 
      csv_line.each do |line|
        email_rule.to = line[email_rule.to_index]
        email_rule.cc = line[email_rule.cc_index]
        email_rule.subject = line[email_rule.subject_index]
        email_rule.body = line[email_rule.body_index]
        email_rule.condition = line[email_rule.condition_index]
      end
    end
    email_rules
  end

  def load_email_rules header
    mapped_rules = []
    mapped_email_rules_count = 0
    csv_line = CSV.parse(header, :col_sep => ?;, headers: false)    
    load_email_rules_settings.each do |email_rule|

      counter_column = 0
      mapped_email_rule = EmailRule.new
      csv_line[0].each do |column|
        map_email_rule(email_rule, mapped_email_rule, column, counter_column)
      end
      mapped_rules[mapped_email_rules_count] = mapped_email_rule
      mapped_email_rules_count = mapped_email_rules_count + 1
    end
    @logger.info "#{mapped_rules.length} email rule(s) mapped"
    return mapped_rules
  end

  def map_email_rule email_rule, mapped_email_rule, column, counter_column
    if(email_rule['to'] == column)
      mapped_email_rule.to_index = counter_column.to_s
    end

    if(email_rule['subject'] == column)
      mapped_email_rule.subject_index = counter_column.to_s          
    end

    if(email_rule['cc'] == column)
      mapped_email_rule.cc_index = counter_column.to_s
    end

    if(email_rule['body'] == column)
      mapped_email_rule.body_index = counter_column.to_s
    end

    if(email_rule['condition'] == column)
      mapped_email_rule.condition_index = counter_column.to_s
    end

    counter_column = counter_column + 1
  end

  def is_first_line counter
    counter == 1
  end

  def is_second_line counter
    counter == 2
  end

  def is_last_line line
    count_column=line.split(";").length
    count_column < 2 and line.include? "FIM;"
  end

  def rename_file_to_processed file
    original_filename = File.absolute_path(file)
    filename_processed = "#{File.absolute_path(file)}.processado"
    @logger.info "Renomeando arquivo ...#{original_filename} para #{filename_processed}"
    File.rename(original_filename, filename_processed)
  end

end