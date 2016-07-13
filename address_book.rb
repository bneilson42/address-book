require_relative "controllers/menu_controller"

menu = MenuController.new

system "clear"
puts "welcome to AddressBook!"

menu.main_menu
