def get_current_mac
  # Retrieve current mac from macchanger
  `macchanger -s #{@netcard_list.text} | awk '/Current/ { print $3 }' | tr -d '\n'`
end

def get_permanent_mac
  # Retrieve permanent mac from macchanger
  `macchanger -s #{@netcard_list.text} | awk '/Permanent/ { print $3 }' | tr -d '\n'`
end

def get_random_mac
  if `sudo macchanger -r #{@netcard_list.text} | awk '/New/ { print $3 }' | tr -d '\n'` == get_current_mac
    @mac_adress_para.replace "Current mac on #{@netcard_list.text}: #{get_current_mac}"
  else
    @mac_adress_para.replace "Error. Interface up? \n Current mac on #{@netcard_list.text}: #{get_current_mac}"
  end
end

def get_a_mac(mac)
  # Il faut supper le /n de la fin de #{mac} (regex)
  if system("sudo macchanger -m #{mac} #{@netcard_list.text}")
    if mac == get_current_mac
      @mac_adress_para.replace "Current mac on #{@netcard_list.text}: #{get_current_mac}"
    else
      @mac_adress_para.replace "Error. Interface up? \n Current mac: #{get_current_mac}"
    end
  else
    if `sudo macchanger -m #{mac} wlan0 | awk '/It/ { print $3 }'` == "same\n"
      @mac_adress_para.replace "Same mac adress. \n Current mac on #{@netcard_list.text}: #{get_current_mac}"
    else
      @mac_adress_para.replace "Invalid mac adress. \n Current mac on #{@netcard_list.text}: #{get_current_mac}"
    end
  end
end