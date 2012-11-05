def get_current_mac
  # Retrieve current mac from macchanger
  `macchanger -s #{@netcard.text} | awk '/Current/ { print $3 }' | tr -d '\n'`
end

def get_permanent_mac
  # Retrieve permanent mac from macchanger
  `macchanger -s #{@netcard.text} | awk '/Permanent/ { print $3 }' | tr -d '\n'`
end

def get_random_mac
  `sudo macchanger -r #{@netcard.text}`
end

def get_a_mac(mac)
  # Il faut supper le /n de la fin de #{mac} (regex)
  if system("sudo macchanger -m #{mac} #{@netcard.text}")
    alert true
    if `sudo macchanger -m #{mac} wlan0 | awk '/ERROR:/ { print $1 }'` == "ERROR:"
      @macadress.replace "Can't request assigned adress. Interface down? \n Current mac: #{get_current_mac}"
    else
      @macadress.replace "Current mac: #{get_current_mac}"
    end
  else
    alert false
    if `sudo macchanger -m #{mac} wlan0 | awk '/It/ { print $3 }'` == "same\n"
      @macadress.replace "Same mac adress. \n Current mac: #{get_current_mac}"
    else
      @macadress.replace "Invalid mac adress. \n Current mac: #{get_current_mac}"
    end
  end
end
