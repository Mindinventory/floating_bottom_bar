part of floating_bottom_bar;

/// [CircularNotchedAndCorneredRectangle] A shape with a notch in its outline.
class CircularNotchedAndCorneredRectangle extends NotchedShape {
  final Animation<double>? animation;
  final NotchSmoothness notchSmoothness;
  final GapLocation gapLocation;

  // final double leftCornerRadius;
  // final double rightCornerRadius;
  final double cornerRadius;

  CircularNotchedAndCorneredRectangle({
    required this.notchSmoothness,
    required this.gapLocation,
    required this.cornerRadius,
    // required this.leftCornerRadius,
    // required this.rightCornerRadius,
    this.animation,
  });

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      if (cornerRadius > 0) {
        double cornerRadius = this.cornerRadius * (animation?.value ?? 1);
        return Path()
          ..moveTo(host.left, host.bottom)
          ..lineTo(host.left, host.top + cornerRadius)
          ..arcToPoint(
            Offset(host.left + cornerRadius, host.top),
            radius: Radius.circular(cornerRadius),
            clockwise: true,
          )
          ..lineTo(host.right - cornerRadius, host.top)
          ..arcToPoint(
            Offset(host.right, host.top + cornerRadius),
            radius: Radius.circular(cornerRadius),
            clockwise: true,
          )
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close();
      }
      return Path()..addRect(host);
    }

    double notchRadius = guest.width / 2 * (animation?.value ?? 1);
    double leftCornerRadius = cornerRadius * (animation?.value ?? 1);
    double rightCornerRadius = cornerRadius * (animation?.value ?? 1);

    final double s1 = notchSmoothness.s1;
    final double s2 = notchSmoothness.s2;

    double r = notchRadius;
    double a = -1.0 * r - s2;
    double b = host.top - guest.center.dy;

    double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    double p2yA = math.sqrt(r * r - p2xA * p2xA);
    double p2yB = math.sqrt(r * r - p2xB * p2xB);

    List<Offset> p = List.filled(6, Offset.zero, growable: true);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
    }

    return Path()
      ..moveTo(host.left, host.bottom)
      ..lineTo(host.left, host.top + leftCornerRadius)
      ..arcToPoint(
        Offset(host.left + leftCornerRadius, host.top),
        radius: Radius.circular(leftCornerRadius),
        clockwise: true,
      )
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(
        p[1].dx,
        p[1].dy,
        p[2].dx,
        p[2].dy,
      )
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - rightCornerRadius, host.top)
      ..arcToPoint(
        Offset(host.right, host.top + rightCornerRadius),
        radius: Radius.circular(rightCornerRadius),
        clockwise: true,
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

extension on NotchSmoothness? {
  static const curveS1 = {
    NotchSmoothness.defaultEdge: 15.0,
  };

  static const curveS2 = {
    NotchSmoothness.defaultEdge: 1.0,
  };

  double get s1 => curveS1[this] ?? 15.0;

  double get s2 => curveS2[this] ?? 1.0;
}
