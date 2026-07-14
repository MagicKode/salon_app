String formatPhone(String phone) {
  if (phone.length == 13 && phone.startsWith('+')) {
    return '+${phone.substring(1, 4)} (${phone.substring(4, 6)}) ${phone.substring(6, 9)}-${phone.substring(9, 11)}-${phone.substring(11)}';
  }
  return phone;
}
