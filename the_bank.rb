require_relative 'bank_classes'

@customers = []
@accounts = []

def welcome_screen
  @current_customer = ""

  puts "Welcome to the Bank"
  puts "Please choose from the following"
  puts "------------------------"
  puts "1. Customer Sign-In"
  puts "2. New Customer Registration"

  choice = gets.chomp.to_i

  case choice
  when 1
    sign_in
  when 2
    sign_up("", "")

  end

end

def sign_in
  print "What's your name?"
  name = gets.chomp
  print "What's your location?"
  location = gets.chomp

  if @customers.empty?
    puts "No customer found with that information"
    sign_up(name, location)
  end
  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && location == customer.location
      @current_customer = customer
      customer_exists = true

  end
  if customer_exists
    account_menu
  else
    puts "No Customer found with that information"
    puts "1. Try again?"
    puts "2. Sign Up"
    choice = gets.chomp.to_i

    case choice
    when 1
      sign_in
    when 2
      sign_up("", "")
    end
  end
end

def sign_up(name, location)
  if name == "" && location == ""
    print "What's your name?"
    name = gets.chomp
    print "What's your location?"
    location = gets.chomp
  end
  @current_customer = Customer.new(name, location)
  @customers.push(@current_customer)
  puts "Registration Successful!"

  account_menu
end

def account_menu
  puts "Account Menu"
  puts "------------"
  puts "1. Create an Account"
  puts "2. Review an Account"
  puts "3. Sign Out"

  choice = gets.chomp.to_i

  case choice
  when 1
    create_account
  when 2
    review_account
  when 3
    puts "Thanks for banking with us."
    welcome_screen
  else
    puts "Invalid Selection"
    account_menu
  end
end

def create_account
  print "How much will your first deposit be?"
  amount = gets.chomp.to_f

  print "What type of account would you like to open?"
  acct_type = gets.chomp

  new_acct = Account.new(@current_customer, amount, (@accounts.length+1), acct_type)
  @accounts.push(new_acct)
  puts "Account created successfully!"
  account_menu
end

def review_account
  @current_account = ""
  print "Which account (type) do you want to review?"
  type = gets.chomp.downcase

  account_exists = false
  @accounts.each do |account|
    if @current_customer == account.customer && type == account.acct_type.downcase
      @current_account = account
      account_exists = true
    end
  end

  if account_exists
    current_account_actions
  else
    puts "Try Again"
    review_account
  end

end

def current_account_actions
  puts "Choose from the following:"
  puts "---------------------"
  puts "1. Balance Check"
  puts "2. Make a Deposit"
  puts "3. Make a Withdrawal"
  puts "4. Return to Account Menu"
  puts "5. Sign Out"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Current balance is $#{'%0.2f'%(@current_account.balance)}"
    current_account_actions
  when 2
    @current_account.deposit
    current_account_actions
  when 3
    @currnet_account.withdrawal
    current_account_actions
  when 4
    review_account
  when 5
    welcome_screen
  else
    puts "Invlaid Selection"
    current_account_actions
  end
end

welcome_screen


