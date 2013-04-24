desc "Generate a set of fake data for use in benchmarking"
task :generate do
  require 'rubygems'
  require 'bundler/setup'
  require 'forgery'
  require 'oj'
  
  company_ids = 1..350
  
  puts "Generating 5000 employee records..."
  employees = []
  1.upto(5000) do |employee_id|
    employee = { 'active' => [true, false].sample,
                 'comments' => Forgery(:lorem_ipsum).words(10..100),
                 'company_id' => rand(company_ids),
                 'created_at' => Forgery(:date).date.to_datetime.iso8601,
                 'email_address' => Forgery(:internet).email_address,
                 'employee_id' => employee_id,
                 'hire_date' => Forgery(:date).date.to_datetime.iso8601,
                 'name' => Forgery(:name).full_name,
                 'position' => ['Engineer', 'Manager', 'Sales Rep', 'CEO', 'Janitor'].sample,
                 'salary' => Forgery(:monetary).money(:min => 40000, :max => 265000),
                 'termination_date' => [nil, Forgery(:date).date.to_datetime.iso8601].sample }
    employees << employee
  end
  File.open(File.dirname(__FILE__) + '/JSON/employees.json', 'w+') { |f| f << Oj.dump({'employees' => employees}) }
  
  puts "Generating 5000 employees with 350 companies using nested mapping..."
  companies = []
  1.upto(350) do |company_id|
    company = { 'active' => [true, false].sample,
                'company_id' => company_id,
                'founding_date' => Forgery(:date).date.to_datetime.iso8601,
                'industry' => %w{Finance Medical Technology Manufacturing Agriculture}.sample,
                'name' => Forgery(:name).company_name,
                'tax_id' => rand(10000..9999999),
                'url' => "http://#{Forgery(:internet).domain_name}" }
    companies << company
  end
  employees_with_nested_companies = employees.dup
  employees_with_nested_companies.each do |employee|
    employee['company'] = companies.sample
  end
  File.open(File.dirname(__FILE__) + '/JSON/employees_with_nested_companies.json', 'w+') { |f| f << Oj.dump({'employees' => employees_with_nested_companies}) }
  
  puts "Generating 5000 employees with primary key connections to 350 companies..."
  employees_with_company_ids = employees.dup
  employees_with_company_ids.each do |employee|
    employee['company_id'] = companies.sample['company_id']
  end
  File.open(File.dirname(__FILE__) + '/JSON/employees_and_companies.json', 'w+') { |f| f << Oj.dump({'companies' => companies, 'employees' => employees_with_company_ids}) }
  
  # TODO: 5000 employees with 350 companies (connected)
end
