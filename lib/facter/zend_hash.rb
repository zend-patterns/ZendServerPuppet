Facter.add('zend_hash') do
          setcode do
            Facter::Util::Resolution.exec('grep "zend_api_key_hash" /etc/facter/facts.d/zend_api_key_hash.txt | cut -d\'=\' -f2')
          end
         end