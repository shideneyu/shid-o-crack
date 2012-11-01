def get_current_mac
  # Retrieve current mac from macchanger
  `macchanger -s wlan0 | awk '/Current/ { print $3 }'`

end

def get_permanent_mac
  # Retrieve permanent mac from macchanger
  `macchanger -s wlan0 | awk '/Permanent/ { print $3 }'`
end

def get_random_mac
  `sudo macchanger -r wlan0`
end

def get_a_mac(mac)
  # Il faut supper le /n de la fin de #{mac} (regex)
  if system("sudo macchanger -m #{mac} wlan0")
    @macadress.replace "Current mac: #{get_current_mac}"
  else
    if `sudo macchanger -m #{mac} wlan0 | awk '/It/ { print $3 }'` == "same\n"
      @macadress.replace "Same mac adress. \n Current mac: #{get_current_mac}"
    else
      @macadress.replace "Invalid mac adress. \n Current mac: #{get_current_mac}"
    end
  end
end
