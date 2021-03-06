class Transaction

	def self.urlWithEntity
		return Config.baseUrl + "/accounts"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end


	# *** GET ***
	#==getAllByAccountId
	#Get all transactions for a specific account
	#Returns an array of hashes.
	#Parameters: AccountID
	#Returns an array of hashes containing the transactions for that account.
	def self.getAllByAccountId(accID)
		url = "#{self.urlWithEntity}/#{accID}/transactions?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
	end

	#==getOneByAccountIdTransactionId
	# Get a specific transaction from a specific account.
	#Parameters: AccountID, TransactionId
	# Returns a hash with the specified transaction
	
	def self.getOneByAccountIdTransactionId(accID, tranID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{tranID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** POST ***

	# Create a new transaction between 2 accounts
	#==createTransaction
	#Creates a new transaction.
	#Parameters: toAccountId, hashWithTransacionData
	#Returns http response code. 
	def self.createTransaction(toAcc, json)
		url = "#{self.urlWithEntity}/#{toAcc}/transactions?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = json
		resp = http.request(request)
		data = JSON.parse(resp.body)
	end


	# *** DELETE ***

	#==deleteTransaction
	#Deletes a specified transaction from a specified account.
	#Parameters: AccountID, TransactionID
	#Returns http response code.
	#=Note:
	#This does not actually delete the transaction from the database, it only sets it's
	#status to 'cancelled'
	def self.deleteTransaction(accID, transID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{transID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		resp = http.request(request)
		data = JSON.parse(resp.body)
	end
end