desc "Generate a set of fake data for use in benchmarking"
task :generate do
  require 'rubygems'
  require 'bundler/setup'
  require 'forgery'
  require 'oj'
  
  company_ids = 1..350
  
  puts "Generating 5000 employee records..."
  employees = { 'employees' => [] }
  1.upto(5000) do |employee_id|
    employee_hash = { 'active' => [true, false].sample,
                      'comments' => Forgery(:lorem_ipsum).words(10..100),
                      'company_id' => rand(company_ids),
                      'created_at' => Forgery(:date),
                      'email_address' => Forgery(:internet).email_address,
                      'employee_id' => employee_id,
                      'hire_date' => Forgery(:date).date,
                      'name' => Forgery(:name).full_name,
                      'position' => ['Engineer', 'Manager', 'Sales Rep', 'CEO', 'Janitor'].sample,
                      'salary' => Forgery(:monetary).money(:min => 40000, :max => 265000),
                      'termination_date' => [nil, Forgery(:date).date].sample
                    }
    employees['employees'] << employee_hash
  end
  File.open(File.dirname(__FILE__) + '/JSON/employees.json', 'w+') { |f| f << Oj.dump(employees) }
  
  # TODO: 5000 employees with 350 companies (nested)
  # TODO: 5000 employees with 350 companies (connected)
end
