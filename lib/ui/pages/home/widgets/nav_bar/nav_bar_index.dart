enum NavBarIndex {
  home(0),
  settings(1);

  final int value;

  const NavBarIndex(this.value);

  factory NavBarIndex.fromInt(final int index) => NavBarIndex.values.firstWhere(
        (final element) => element.value == index,
    orElse: () => NavBarIndex.home,
  );
}
