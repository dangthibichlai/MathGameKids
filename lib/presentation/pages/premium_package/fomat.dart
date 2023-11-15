extension ExDouble on double {
  String toVnd() {
    final String st = '${toInt()}';
    String st2 = ' vnd';

    int d = 0;
    for (int i = st.length - 1; i >= 0; i--) {
      st2 = '${st[i]}$st2';
      d++;

      if ((d == 3) && (i > 0)) {
        st2 = '.$st2';
        d = 0;
      }
    }

    return st2;
  }
}