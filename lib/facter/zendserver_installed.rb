Facter.add(:zendserver_installed) do
	confine :kernel => :linux
	setcode do
	Facter.debug('zendserver_installedzendserver_installedzendserver_installedzendserver_installedzendserver_installedzendserver_installedzendserver_installed')
		if FileTest.exists?("/usr/local/zend/bin")
			"true"
		else
			"false"
		end
	end
end
