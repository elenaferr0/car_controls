enum NavBarIndex {
  home(0),
  notifications(1),
  settings(2);

  final int value;

  const NavBarIndex(this.value);

  factory NavBarIndex.fromInt(final int index) => NavBarIndex.values.firstWhere(
        (final element) => element.value == index,
    orElse: () => NavBarIndex.home,
  );
}
