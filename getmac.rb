def get_current_mac
  # Retrieve and retrieved mac from ifconfig and removing the line return
  `ifconfig wlan0 |  grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | tr -d '\n'`
end

def get_random_mac
  `sudo macchanger -r wlan0`
  @macadress.replace "Current mac: #{get_current_mac}"
end

def get_a_mac(mac)
  # Il faut supper le /n de la fin de #{mac} (regex)
  if system("sudo macchanger -m #{mac} wlan0")
    @macadress.replace "Current mac: #{get_current_mac}"
  else
    @macadress.replace "Invalid mac adress. \n Current mac: #{get_current_mac}"
  end
end
