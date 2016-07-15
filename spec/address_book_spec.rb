require_relative '../models/address_book.rb'

 RSpec.describe AddressBook do

   let(:book) { AddressBook.new }

   def check_entry(entry, expected_name, expected_number, expected_email)
     expect(entry.name).to eq expected_name
     expect(entry.phone_number).to eq expected_number
     expect(entry.email).to eq expected_email
   end

   context "attributes" do
     it "should respond to entries" do
       expect(book).to respond_to(:entries)
     end

     it "should initialize entries as an array" do
       expect(book.entries).to be_a(Array)
     end

     it "should initialize entries as empty" do
       expect(book.entries.size).to eq 0
     end
   end

   context "#remove_entry" do
     it "removes an entry using name, phone_number, and email address" do
       book.add_entry("darb nosl", "555.555.5555", "darb@gmail.com")

       name = "Brad Neilson"
       phone_number = "555.555.5555"
       email_address = "brad@gmail.com"
       book.add_entry(name, phone_number, email_address)

       expect(book.entries.size).to eq 2
       book.remove_entry(name, phone_number, email_address)
       expect(book.entries.size).to eq 1
       expect(book.entries.first.name).to eq("darb nosl")
     end
   end

   context "#add_entry" do
     it "adds only one entry to the address book" do
       book.add_entry('Darby Noslien', '555.555.5555', 'darby@gmail.com')

       expect(book.entries.size).to eq 1
     end

     it "adds the correct information to entries" do
       book.add_entry('Darby Noslien', '555.555.5555', 'darby@gmail.com')
       new_entry = book.entries[0]

       expect(new_entry.name).to eq 'Darby Noslien'
       expect(new_entry.phone_number).to eq '555.555.5555'
       expect(new_entry.email).to eq 'darby@gmail.com'
     end
   end

   context ".import_from_csv" do
     it "imports the correct number of entries" do
       book.import_from_csv("entries.csv")
       book_size = book.entries.size

       expect(book_size).to eq 5
     end

     it "imports the 1st entry" do
       book.import_from_csv("entries.csv")
       entry_one = book.entries[0]

       check_entry(entry_one, "Bob", "555.555.5556", "bob@gmail.com")
     end

     it "imports the 2nd entry" do
       book.import_from_csv("entries.csv")
       entry_two = book.entries[2]

       check_entry(entry_two, "Joe", "555.555.5557", "joe@gmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       entry_three = book.entries[4]

       check_entry(entry_three, "Pete", "555.555.5558", "pete@gmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       entry_four = book.entries[1]

       check_entry(entry_four, "Jim", "555.555.5559", "jim@gmail.com")
     end

     it "imports the 5th entry" do
       book.import_from_csv("entries.csv")
       entry_five = book.entries[3]

       check_entry(entry_five, "John", "555.555.5560", "john@gmail.com")
     end
   end

   context "importing from entries_2.csv" do
      it "imports the correct number of entries" do
        book.import_from_csv("entries_2.csv")

        expect(book.entries.size).to eq 3
      end

     it "imports the 1st entry" do
       book.import_from_csv("entries_2.csv")
       entry_one = book.entries[0]
       check_entry(entry_one, "Brad", "555.555.5561", "brad@gmail.com")
     end

     it "imports the 2nd entry" do
       book.import_from_csv("entries_2.csv")
       entry_two = book.entries[2]
       check_entry(entry_two, "Steve", "555.555.5562", "steve@gmail.com")
     end

     it "imports the 3rd entry" do
       book.import_from_csv("entries_2.csv")
       entry_three = book.entries[1]
       check_entry(entry_three, "Carl", "555.555.5563", "carl@gmail.com")
     end
   end

   context "#binary_search" do
     it "searches AddressBook for a non-existing entry" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Dan")
       expect(entry).to be_nil
     end

     it "searches AddressBook for Bill" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bill")
       expect(entry).to be_a Entry
       check_entry(entry, "Bill", "555.555.5570", "bill@gmail.com")
     end

     it "searches AddressBook for Al" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Al")
       expect(entry).to be_a Entry
       check_entry(entry, "Al", "555.555.5571", "al@gmail.com")
     end

     it "searches AddressBook for Chris" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Chris")
       expect(entry).to be_a Entry
       check_entry(entry, "Chris", "555.555.5572", "chris@gmail.com")
     end

     it "searches AddressBook for Phil" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Phil")
       expect(entry).to be_a Entry
       check_entry(entry, "Phil", "555.555.5573", "phil@gmail.com")
     end

     it "searches AddressBook for Les" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Les")
       expect(entry).to be_a Entry
       check_entry(entry, "Les", "555.555.5574", "les@gmail.com")
     end

     it "searches AddressBook for Alex" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Alex")
       expect(entry).to be_nil
     end
   end
end
